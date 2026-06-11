#WC1
setwd("C:/Users/samue/OneDrive/Documenti/Transcriptomics/Casus")
getwd()
install.packages('BiocManager')
BiocManager::install('Rsubread')
library(Rsubread)
browseVignettes('Rsubread')

buildindex(
  basename = 'ref_human',
  reference = 'GCF_000001405.39_GRCh38.p13_genomic.fna',
  memory = 4000,
  indexSplit = TRUE)

align.NOR1 <- align(index = "ref_human", readfile1 = "SRR4785819_1_subset40k.fastq", readfile2 = "SRR4785819_2_subset40k.fastq", output_file = "NOR1.BAM")
align.NOR2 <- align(index = "ref_human", readfile1 = "SRR4785820_1_subset40k.fastq", readfile2 = "SRR4785820_2_subset40k.fastq", output_file = "NOR2.BAM")
align.NOR3 <- align(index = "ref_human", readfile1 = "SRR4785828_1_subset40k.fastq", readfile2 = "SRR4785828_2_subset40k.fastq", output_file = "NOR3.BAM")
align.NOR4 <- align(index = "ref_human", readfile1 = "SRR4785831_1_subset40k.fastq", readfile2 = "SRR4785831_2_subset40k.fastq", output_file = "NOR4.BAM")
align.RA1 <- align(index = "ref_human", readfile1 = "SRR4785979_1_subset40k.fastq", readfile2 = "SRR4785979_2_subset40k.fastq", output_file = "RA1.BAM")
align.RA2 <- align(index = "ref_human", readfile1 = "SRR4785980_1_subset40k.fastq", readfile2 = "SRR4785980_2_subset40k.fastq", output_file = "RA2.BAM")
align.RA3 <- align(index = "ref_human", readfile1 = "SRR4785986_1_subset40k.fastq", readfile2 = "SRR4785986_2_subset40k.fastq", output_file = "RA3.BAM")
align.RA4 <- align(index = "ref_human", readfile1 = "SRR4785988_1_subset40k.fastq", readfile2 = "SRR4785988_2_subset40k.fastq", output_file = "RA4.BAM")

BiocManager::install('Rsamtools')
library(Rsamtools)

samples <- c('NOR1', 'NOR2', 'NOR3', 'NOR4', 'RA1', 'RA2', 'RA3', 'RA4')
samples

lapply(samples, function(s) {sortBam(file = paste0(s, '.BAM'), destination = paste0(s, '.sorted'))
})
lapply(samples, function(s) {indexBam(file = paste0(s, '.sorted.bam'))
})

#WC2
library(Rsubread)

setwd("C:/Users/samue/OneDrive/Documenti/Transcriptomics/Casus")

allsamples <- c("NOR1.BAM", "NOR2.BAM", "NOR3.BAM", "NOR3.BAM", "RA1.BAM", "RA2.BAM", "RA3.BAM", "RA3.BAM")

count_matrix <- featureCounts(
  files = allsamples,
  annot.ext = "genomic.gtf",
  isPairedEnd = TRUE,
  isGTFAnnotationFile = TRUE, 
  GTF.attrType = "gene_id",
  useMetaFeatures = TRUE
)

str(count_matrix)

counts <- count_matrix$counts
head(counts)

colnames(counts) <- c('NOR1', 'NOR2', 'NOR3', 'NOR4', 'RA1', 'RA2', 'RA3', 'RA4')
head(counts)

write.csv(counts, "human_countmatrix.csv")

#WC3
setwd("C:/Users/samue/OneDrive/Documenti/Transcriptomics/Casus")

counts <- read.table("count_matrix_RA.txt", row.names = 1)
counts

BiocManager::install("DESeq2")
BiocManager::install("KEGGREST")
BiocManager::install("EnhancedVolcano")
BiocManager::install("pathview")

library(DESeq2)
library(KEGGREST)
library(EnhancedVolcano)
library(pathview)

treatment <- c("normal", "normal", "normal", "normal", "Rheumatoid arthritis", "Rheumatoid arthritis", "Rheumatoid arthritis", "Rheumatoid arthritis")
treatment_table <- data.frame(treatment)

rownames(treatment_table) <- c('NOR1', 'NOR2', 'NOR3', 'NOR4', 'RA1', 'RA2', 'RA3', 'RA4')
head(treatment_table)

dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = treatment_table,
                              design = ~ treatment)

dds <- DESeq(dds)
resultaten <- results(dds)
resultaten

sum(resultaten$padj < 0.05 & resultaten$log2FoldChange > 1, na.rm = TRUE)
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange < -1, na.rm = TRUE)

hoogste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = TRUE), ]
laagste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = FALSE), ]
laagste_p_waarde <- resultaten[order(resultaten$padj, decreasing = FALSE), ]

EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj')

dev.copy(png, 'VolcanoplotWC.png', 
         width = 8,
         height = 10,
         units = 'in',
         res = 500)
dev.off()

#GO-analyse
BiocManager::install("goseq")
library(goseq)

de_genes <- rownames(resultaten)[which(resultaten$padj < 0.05)]


gene_vector <- as.integer(rownames(resultaten) %in% de_genes)
names(gene_vector) <- rownames(resultaten)


table(gene_vector)

supportedOrganisms()

pwf <- nullp(gene_vector, "hg19", "geneSymbol")

GO_results <- goseq(pwf, "hg19", "geneSymbol")

head(GO_results)

sig_GO <- GO_results[GO_results$over_represented_pvalue < 0.05, ]

sig_GO <- sig_GO[order(sig_GO$over_represented_pvalue), ]

head(sig_GO, 10)

write.csv(sig_GO, "GO_results_RA.csv")

library(dplyr)
library(ggplot2)

topGO <- sig_GO %>%
  slice_min(order_by = over_represented_pvalue, n = 10) %>%
  mutate(hitsPerc = numDEInCat * 100 / numInCat)

ggplot(topGO, aes(x = hitsPerc,
                  y = reorder(term, hitsPerc),
                  colour = over_represented_pvalue,
                  size = numDEInCat)) +
  geom_point() +
  labs(x = "Hits (%)",
       y = "GO term",
       colour = "p-value",
       size = "Number of DE genes",
       title = "Top 10 GO terms (RA vs Control)") +
  theme_minimal()

#pathway
res_def <- as.data.frame(resultaten)
gene.data <- res_def$log2Foldchange
resultaten2 <- res_def
resultaten2[1] <- NULL
resultaten2[2:5] <- NULL

pathview(
  gene.data = resultaten,
  pathway.id = "hsa05320",  
  species = "hsa",          
  gene.idtype = "SYMBOL",     
  limit = list(gene = 5)    
)