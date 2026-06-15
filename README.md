
# 🧬 Transcriptomics Analysis of Rheumatoid Arthritis

## 📌 Project Description  
Reumatoïde artritis (RA) is een chronische systemische auto-immuunziekte die wordt gekenmerkt door ontsteking van het gewrichtsslijmvlies (synovitis), wat leidt tot progressieve gewrichtsschade. De oorzaak van RA is multifactorieel en omvat genetische aanleg, omgevingsfactoren en een ontregeld immuunsysteem.  

In dit project wordt transcriptomics gebruikt om verschillen in genexpressie tussen RA-patiënten en gezonde controles te analyseren. Door middel van RNA-seq data worden genen en biologische pathways geïdentificeerd die betrokken zijn bij het ziekteproces.  

---

## 🎯 Doelstelling  
Het doel van deze studie is om:  
- differentieel geëxprimeerde genen te identificeren tussen RA en controles  
- inzicht te krijgen in betrokken biologische processen  
- relevante pathways te bepalen die een rol spelen in RA  

---

## 📂 Dataset  
- 4 RA samples 
- 4 controle samples  
- RNA-seq paired-end data  
- Referentiegenoom: GRCh38  

---

## 🔬 Methode  

Voor deze analyse is gebruikgemaakt van RNA-seq data afkomstig van synoviaal weefsel van vier patiënten met reumatoïde artritis (RA) en vier gezonde controles. De ruwe sequencing reads (FASTQ-bestanden) zijn uitgelijnd tegen het humane referentiegenoom (GRCh38) met behulp van het *Rsubread* package (v2.18.0) in R (v4.4.1). Voor elke sample is een BAM-bestand gegenereerd, waarna deze bestanden zijn gesorteerd en geïndexeerd met het *Rsamtools* package (v2.20.0).  

Vervolgens is genquantificatie uitgevoerd met *featureCounts*, waarbij reads werden toegewezen aan genen op basis van een GTF-annotatiebestand. Dit resulteerde in een count matrix met het aantal reads per gen per sample.  

De differentiële expressieanalyse is uitgevoerd met *DESeq2* (v1.44.0), waarbij genen als significant werden beschouwd bij een adjusted p-value < 0.05 en |log2 fold change| > 1. Visualisatie is uitgevoerd met *EnhancedVolcano* (v1.22.0).  

Functionele analyse is uitgevoerd met *goseq* (v1.56.0) voor Gene Ontology en met *pathview* (v1.44.0) en *KEGGREST* (v1.44.0) voor pathway-analyse. Visualisaties zijn gemaakt met *ggplot2* (v3.5.1) en *dplyr* (v1.1.4).  

---
