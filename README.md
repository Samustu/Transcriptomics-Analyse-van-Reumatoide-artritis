
#  Transcriptomics-Analyse-van-Reumatoïde-artritis

##  Inleiding  
Reumatoïde artritis (RA) is een chronische auto-immuunziekte die wordt gekenmerkt door ontsteking van synoviaal weefsel en progressieve gewrichtsschade. In deze aandoening migreren immuuncellen zoals T‑cellen, B‑cellen en macrofagen naar het gewricht, waar zij ontstekingsprocessen en weefselafbraak veroorzaken (Miyabe et al., 2020). Chemokines en cytokines spelen hierbij een belangrijke rol doordat zij de activatie en rekrutering van immuuncellen reguleren en zo bijdragen aan de pathologie van RA (Miyabe et al., 2020).  

RNA sequencing (RNA-seq) maakt het mogelijk om genexpressie op genome-wide niveau te analyseren en verschillen tussen ziekte en controle te identificeren. Deze techniek wordt veel gebruikt om moleculaire mechanismen van ziekten te bestuderen en nieuwe biologische inzichten te verkrijgen (Love et al., 2014; Stephenson et al., 2018).  

Het doel van dit project is om met behulp van RNA-seq data differentieel geëxprimeerde genen tussen RA-patiënten en gezonde controles te identificeren. Daarnaast wordt onderzocht welke biologische processen (Gene Ontology) en pathways (KEGG) betrokken zijn bij de ziekte. Deze analyse draagt bij aan een beter begrip van de moleculaire basis van RA.

---

##  Methode  
Voor deze studie is RNA sequencing (RNA-seq) data gebruikt van synoviaal weefsel: 4 reumatoïde artritis (RA) samples en 4 gezonde controles. RNA-seq maakt het mogelijk om genexpressie genome-wide te analyseren.  

De analyse is uitgevoerd in R (v4.4.1) en Bioconductor (v3.19). Ruwe reads zijn uitgelijnd tegen het humane referentiegenoom (GRCh38) met Rsubread (v2.18.0). Vervolgens zijn reads toegewezen aan genen met featureCounts (v2.18.0), wat resulteerde in een count matrix.  

Differentiële genexpressieanalyse is uitgevoerd met DESeq2 (v1.44.0), waarbij genen met een adjusted p-value < 0.05 en |log2 fold change| > 1 als significant werden beschouwd.  

Functionele analyse is uitgevoerd met goseq (v1.56.0) voor Gene Ontology, waarbij bias in RNA-seq data wordt gecorrigeerd. KEGG pathway analyse is uitgevoerd met KEGGREST (v1.44.0) en gevisualiseerd met pathview (v1.44.0).  

---

##  Resultaten  

De differentiële expressieanalyse toonde een groot aantal genen met significante veranderingen tussen RA en controles. De volcano plot laat zowel up- als downregulated genen zien, waarbij meerdere genen een hoge log2 fold change en lage p-waarde vertonen. Voorbeelden van sterk gereguleerde genen zijn *IGHV3-53*, *BCL2A1* en *PTGFR*, die betrokken zijn bij immuunresponsen.  

De Gene Ontology analyse laat zien dat de meeste differentieel geëxprimeerde genen betrokken zijn bij immuungerelateerde processen, zoals *immune response*, *leukocyte activation* en *adaptive immune response*. Daarnaast wordt een sterke verrijking gevonden voor het *immunoglobulin complex*, wat wijst op een belangrijke rol van B-cellen en antilichamen.  

### Volcano plot  
<p align="center">
  <img src="resultaten/Figuren/VolcanoplotWC.png" width="600"/>
</p>

### GO analyse (Top 10)  
<p align="center">
  <img src="resultaten/Figuren/GO_Results_plot.png" width="600"/>
</p>

### KEGG pathway (detail gebruikt in analyse)  
<p align="center">
  <img src="resultaten/Figuren/hsa05320.pathview.png" width="600"/>
</p>

---

##  Conclusie  

De resultaten tonen aan dat reumatoïde artritis sterk wordt gekenmerkt door ontregeling van het immuunsysteem. Met name processen zoals adaptieve immuunrespons, leukocytenactivatie en antilichaamvorming spelen een belangrijke rol.  

De analyse van T-cel activatie laat zien dat signaleringsroutes betrokken bij immuunactivatie verhoogd actief zijn bij RA-patiënten. Deze inzichten dragen bij aan een beter begrip van de ziekte en kunnen helpen bij het identificeren van nieuwe therapeutische doelwitten.  
