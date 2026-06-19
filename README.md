
#  Transcriptomics-Analyse-van-Reumatoïde-artritis

##  Inleiding  
Reumatoïde artritis (RA) is een chronische auto-immuunziekte die wordt gekenmerkt door ontsteking van synoviaal weefsel en progressieve gewrichtsschade. Immuuncellen zoals T-cellen, B-cellen en macrofagen infiltreren het gewricht en veroorzaken ontstekingsprocessen en weefselafbraak (Miyabe et al., 2020). Chemokines en cytokines spelen hierbij een belangrijke rol doordat zij de activatie en migratie van immuuncellen reguleren (Miyabe et al., 2020).

RNA sequencing (RNA-seq) maakt het mogelijk om genexpressie op genome-wide niveau te analyseren en verschillen tussen ziekte en controle te identificeren. Deze techniek wordt veel toegepast om de moleculaire mechanismen achter complexe ziekten, zoals RA, beter te begrijpen (Love et al., 2014; Stephenson et al., 2018).

Het doel van dit project is om met behulp van RNA-seq data inzicht te verkrijgen in de moleculaire processen die betrokken zijn bij reumatoïde artritis. Hiervoor wordt eerst onderzocht welke genen significant differentieel geëxprimeerd zijn tussen RA-patiënten en gezonde controles. Vervolgens wordt met een Gene Ontology (GO)-analyse bepaald welke biologische processen verrijkt zijn onder deze differentieel geëxprimeerde genen. Ten slotte wordt gekeken welke genen en immuunmechanismen betrokken zijn binnen de KEGG pathway *Autoimmune Thyroid Disease* (hsa05320) en hoe deze samenhangen met de gevonden genexpressieveranderingen. Door deze analyses te combineren kan beter worden begrepen welke moleculaire en immunologische processen een rol spelen bij RA.

---

##  Methode  
Voor deze studie is RNA sequencing (RNA-seq) data gebruikt van synoviaal weefsel: 4 reumatoïde artritis (RA) samples en 4 gezonde controles. RNA-seq maakt het mogelijk om genexpressie genome-wide te analyseren.  

De analyse is uitgevoerd in R (v4.4.1) en Bioconductor (v3.19). Ruwe reads zijn uitgelijnd tegen het humane referentiegenoom (GRCh38) met Rsubread (v2.18.0). Vervolgens zijn reads toegewezen aan genen met featureCounts (v2.18.0), wat resulteerde in een count matrix.  

Differentiële genexpressieanalyse is uitgevoerd met DESeq2 (v1.44.0), waarbij genen met een adjusted p-value < 0.05 en |log2 fold change| > 1 als significant werden beschouwd.  

Functionele analyse is uitgevoerd met goseq (v1.56.0) voor Gene Ontology, waarbij bias in RNA-seq data wordt gecorrigeerd. KEGG pathway analyse is uitgevoerd met KEGGREST (v1.44.0) en gevisualiseerd met pathview (v1.44.0).  



| Naam | Conditie |
|------|-----------|
| SRR4785819 | Normal |
| SRR4785820 | Normal |
| SRR4785828 | Normal |
| SRR4785831 | Normal |
| SRR4785979 | Rheumatoid arthritis |
| SRR4785980 | Rheumatoid arthritis |
| SRR4785986 | Rheumatoid arthritis |
| SRR4785988 | Rheumatoid arthritis |

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
