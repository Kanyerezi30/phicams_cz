library(dplyr)
library(readxl)
library(ggplot2)
library(knitr)
library(kableExtra)
library(tidyr)
library(stringr)
library(MASS)
library(FRACTION)
library(xlsx)
# Above 37 degrees C
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/temp/known_above37", header = F)

amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:101]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/temp/domainabove37", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "green", 
                ifelse(value == "bacteria", "yellow", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "green", "bacteria" = "yellow")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "darkblue"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

# Below 37 degrees C
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/temp/known_below37", header = F)


amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:101]
amr62 <- t(amr62[order(rowSums(amr62)),])

domainbelow <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/temp/domainbelow37", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "green", 
                ifelse(value == "bacteria", "yellow", "purple")))
}

domainbelow$color <- value_to_color(domainbelow$V2)
domain_color <- domainbelow$color
heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "darkblue"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domain_color)


# temperatures

amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/temp/alltemps", header = F)

names(amr) <- c("Temperature category", "Pathogen")
amr2 <- amr %>% 
  group_by(`Temperature category`, Pathogen) %>% 
  dplyr::summarise(Count = n(), .groups = 'drop')

amr3 <- amr2 %>% 
  pivot_wider(names_from = Pathogen, values_from = Count)
amr3[is.na(amr3)] <- 0

data_long <- amr2 %>% 
  group_by(Pathogen) %>% 
  arrange(desc(Count)) %>% 
  ungroup()

# Plot the stacked bar plot
ggplot(data_long, aes(x = reorder(Pathogen, Count), y = Count, fill = `Temperature category`)) +
  geom_bar(stat = "identity") +
  labs(x = "Pathogen", y = "Count", fill = "Temperature Category") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for better readability
        axis.text = element_text(size = 6),  # Reduce text size for axis labels
        legend.text = element_text(size = 6))  +
  coord_flip()


ggplot(amr2, aes(x = Pathogen, y = Count, fill = `Temperature category`)) +
  geom_bar(stat = "identity") +
  labs(x = "Pathogen", y = "Count", fill = "Temperature Category") +
  theme_minimal() +
  coord_flip()


# Regime

## ABC-3TC-DTG
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/abc-3tc-dtg.csv", header = F)

amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:95]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/domainabc-3tc-dtg.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "green", 
                ifelse(value == "bacteria", "yellow", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "green", "bacteria" = "yellow")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "darkblue"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

## ABC-3TC-LPV/r
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/abc-3tc-lpv.csv", header = F)

amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:39]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/domainabc-3tc-lpv.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "green", 
                ifelse(value == "bacteria", "yellow", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "green", "bacteria" = "yellow")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "darkblue"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

## AZT-3TC-DTG
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/azt-3tc-dtg.csv", header = F)

amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:60]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/domainazt-3tc-dtg.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "green", 
                ifelse(value == "bacteria", "yellow", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "green", "bacteria" = "yellow")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "darkblue"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

## AZT-3Tc-LPV/r
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/azt-3tc-lpv.csv", header = F)

amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:45]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/domainazt-3tc-lpv.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "green", 
                ifelse(value == "bacteria", "yellow", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "green", "bacteria" = "yellow")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "darkblue"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

## TDF-3TC-DTG
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/tdf-3tc-dtg.csv", header = F)

amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:74]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/domaintdf-3tc-dtg.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "green", 
                ifelse(value == "bacteria", "yellow", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "green", "bacteria" = "yellow")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "darkblue"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

## Newly diagnosed
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/newly_diagnosed.csv", header = F)

amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:82]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/domainnewly_diagnosed.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "green", 
                ifelse(value == "bacteria", "yellow", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "green", "bacteria" = "yellow")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "darkblue"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)


## ALl regime
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/allregime.csv", header = F)

names(amr) <- c("Regime", "Pathogen")
amr2 <- amr %>% 
  group_by(Regime, Pathogen) %>% 
  dplyr::summarise(Count = n(), .groups = 'drop')

amr3 <- amr2 %>% 
  pivot_wider(names_from = Pathogen, values_from = Count)
amr3[is.na(amr3)] <- 0

data_long <- amr2 %>% 
  group_by(Pathogen) %>% 
  arrange(desc(Count)) %>% 
  ungroup()

# Plot the stacked bar plot
ggplot(data_long, aes(x = reorder(Pathogen, Count), y = Count, fill = Regime)) +
  geom_bar(stat = "identity") +
  labs(x = "Pathogen", y = "Count", fill = "Regime") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for better readability
        axis.text = element_text(size = 6),  # Reduce text size for axis labels
        legend.text = element_text(size = 6))  +
  coord_flip()


## all regime presence absence
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/allpresenceabs", header = F)
View(amr)
amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:116]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/domainallpresenceabs.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "green", 
                ifelse(value == "bacteria", "yellow", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "green", "bacteria" = "yellow")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "darkblue"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)


par(xpd = TRUE)  # Allow plotting outside plot region

legend("bottomright", inset = c(-0.63, 0), legend = c("Viruses", "Eukaryota", "Bacteria", "Present", "Absent"), 
       fill = c("red", "green", "yellow", "darkblue", "lightgrey"), cex = 0.8, text.width = 0.6, bty = "n")
# Blood cells
## monocytes pres abs
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/monocytes/monocytespresabs.csv", header = F)
amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:119]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/monocytes/domainmonocytespresabs.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "goldenrod4", 
                ifelse(value == "bacteria", "darkolivegreen3", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "goldenrod4", "bacteria" = "darkolivegreen3")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "steelblue4"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

## eosinophil pres abs

amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/eosinophils/eosinophilpresabs.csv", header = F)
amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:119]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/eosinophils/domaineosinophilpresabs.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "goldenrod4", 
                ifelse(value == "bacteria", "darkolivegreen3", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "goldenrod4", "bacteria" = "darkolivegreen3")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "steelblue4"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

## lymphocytes pres abs

amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/lymphocytes/lymphocytespresabs.csv", header = F)
amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:119]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/lymphocytes/domainlymphocytespresabs.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "goldenrod4", 
                ifelse(value == "bacteria", "darkolivegreen3", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "goldenrod4", "bacteria" = "darkolivegreen3")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "steelblue4"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

## basophils pres abs
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/basophils/basophilspresabs.csv", header = F)
amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:119]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/basophils/domainbasophilspresabs.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "red",
         ifelse(value == "eukaryota", "goldenrod4", 
                ifelse(value == "bacteria", "darkolivegreen3", "purple")))
}
category_colors <- c("viruses" = "red", "eukaryota" = "goldenrod4", "bacteria" = "darkolivegreen3")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("lightgrey", "steelblue4"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)



## Normal

amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/normalpresabs.csv", header = F)
amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:119]
amr62 <- t(amr62[order(rowSums(amr62)),])


domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/domainnormal.csv", header = F)
value_to_color <- function(value){
  ifelse(value == "viruses", "#9b19f5",
         ifelse(value == "eukaryota", "#dc0ab4", 
                ifelse(value == "bacteria", "#50e991", "blue")))
}
category_colors <- c("viruses" = "#9b19f5", "eukaryota" = "#dc0ab4", "bacteria" = "#50e991")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("white", "#0d88e6"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

par(xpd = TRUE)  # Allow plotting outside plot region

legend("bottomright", inset = c(-0.63, 0), legend = c("Viruses", "Eukaryota", "Bacteria", "Present", "Absent"), 
       fill = c("#9b19f5", "#dc0ab4", "#50e991", "#0d88e6", "white"), cex = 0.8, text.width = 0.6, bty = "n")
## above
# 
# amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/abovepresabs.csv", header = F)
# amr <- amr[,c(1,2)]
# amr2 <- amr %>% group_by(V2, V1) %>% 
#   summarise(Count = n())
# # View(amr2)
# amr3 <- amr2 %>% 
#   distinct(V2, V1) %>% 
#   pivot_wider(names_from = V1, values_from = V1, 
#               values_fn = list(V1 = length), values_fill = list(V1 = 0)) 
# 
# amr3 <- as.matrix(amr3)
# # View(amr3)
# amr4 <- amr3
# rownames(amr4) <- amr4[,1]
# amr4 <- as.data.frame(amr4)
# amr4 <- amr4[,-1]
# # View(amr4)
# # amr4 <- as.numeric(amr4)
# amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
# amr4 <- as.matrix(amr4)
# 
# # write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
# amr4 <- as.data.frame(amr4)
# amr4$Total <- rowSums(amr4)
# 
# amr5 <- amr4
# 
# amr5 <- as.matrix(amr5)
# 
# amr6 <- amr5
# # View(amr6)
# amr62 <- amr5[order(rowSums(amr5)),]
# amr62 <- amr62[,1:105]
# amr62 <- t(amr62[order(rowSums(amr62)),])
# 
# 
# domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/domainabove.csv", header = F)
# value_to_color <- function(value){
#   ifelse(value == "viruses", "red",
#          ifelse(value == "eukaryota", "goldenrod4", 
#                 ifelse(value == "bacteria", "darkolivegreen3", "purple")))
# }
# category_colors <- c("viruses" = "red", "eukaryota" = "goldenrod4", "bacteria" = "darkolivegreen3")
# 
# domainabove$color <- value_to_color(domainabove$V2)
# domain_color <- domainabove$color
# 
# heatmap(amr62,
#         scale = "none",
#         Rowv = NA, 
#         Colv = NA, 
#         col=c("lightgrey", "steelblue4"),
#         cexCol = 0.8,
#         cexRow = 0.8,
#         width = 5,
#         height = 5,
#         RowSideColors = domainabove$color)


amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/abovepresabs.csv", header = F)
amr <- amr[,c(1,2)]

# Summarize and pivot the data
amr2 <- amr %>% group_by(V2, V1) %>% summarise(Count = n())
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

# Convert to matrix and process the data
amr3 <- as.matrix(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)
amr5 <- as.matrix(amr4)
amr6 <- amr5
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:105]
amr62 <- t(amr62[order(rowSums(amr62)),])

# Reorder the columns to your specified order
desired_order <- c("monocytes", "lymphocytes", "neutrophils", "eosinophils", "basophils")
amr62 <- amr62[, desired_order]


# Read in the domain data and set colors
domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/domainabove.csv", header = F)
# value_to_color <- function(value){
#   ifelse(value == "viruses", "red",
#          ifelse(value == "eukaryota", "goldenrod4", 
#                 ifelse(value == "bacteria", "darkolivegreen3", "purple")))
# }
value_to_color <- function(value){
  ifelse(value == "viruses", "#9b19f5",
         ifelse(value == "eukaryota", "#dc0ab4", 
                ifelse(value == "bacteria", "#50e991", "blue")))
}
domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

# Plot the heatmap with reordered columns
# heatmap(amr62,
#         scale = "none",
#         Rowv = NA, 
#         Colv = NA, 
#         col = c("white", "steelblue4"),
#         cexCol = 0.8,
#         cexRow = 0.8,
#         width = 5,
#         height = 5,
#         RowSideColors = domainabove$color)

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("white", "#0d88e6"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

par(xpd = TRUE)  # Allow plotting outside plot region

# legend("bottomright", inset = c(-0.63, 0), legend = c("Viruses", "Eukaryota", "Bacteria", "Present", "Absent"), 
#        fill = c("red", "goldenrod4", "darkolivegreen3", "steelblue4", "lightgrey"), cex = 0.8, text.width = 0.6, bty = "n")
legend("bottomright", inset = c(-0.63, 0), legend = c("Viruses", "Eukaryota", "Bacteria", "Present", "Absent"), 
       fill = c("#9b19f5", "#dc0ab4", "#50e991", "#0d88e6", "white"), cex = 0.8, text.width = 0.6, bty = "n")
## below
amr <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/belowpresabs.csv", header = F)
amr <- amr[,c(1,2)]
amr2 <- amr %>% group_by(V2, V1) %>% 
  summarise(Count = n())
# View(amr2)
amr3 <- amr2 %>% 
  distinct(V2, V1) %>% 
  pivot_wider(names_from = V1, values_from = V1, 
              values_fn = list(V1 = length), values_fill = list(V1 = 0)) 

amr3 <- as.matrix(amr3)
# View(amr3)
amr4 <- amr3
rownames(amr4) <- amr4[,1]
amr4 <- as.data.frame(amr4)
amr4 <- amr4[,-1]
# View(amr4)
# amr4 <- as.numeric(amr4)
amr4 <- mutate_all(amr4, function(x) as.numeric(as.character(x)))
amr4 <- as.matrix(amr4)

# write.xlsx(amr4, file = "genes.xlsx", sheetName = "all")
amr4 <- as.data.frame(amr4)
amr4$Total <- rowSums(amr4)

amr5 <- amr4

amr5 <- as.matrix(amr5)

amr6 <- amr5
# View(amr6)
amr62 <- amr5[order(rowSums(amr5)),]
amr62 <- amr62[,1:78]
amr62 <- t(amr62[order(rowSums(amr62)),])

# Reorder the columns to your specified order
desired_order <- c("monocytes", "lymphocytes", "neutrophils", "eosinophils", "basophils")
amr62 <- amr62[, desired_order]

domainabove <- read.csv("~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/blood_Cells/domainbelow.csv", header = F)
# value_to_color <- function(value){
#   ifelse(value == "viruses", "red",
#          ifelse(value == "eukaryota", "goldenrod4", 
#                 ifelse(value == "bacteria", "darkolivegreen3", "purple")))
# }
value_to_color <- function(value){
  ifelse(value == "viruses", "#9b19f5",
         ifelse(value == "eukaryota", "#dc0ab4", 
                ifelse(value == "bacteria", "#50e991", "blue")))
}
# category_colors <- c("viruses" = "red", "eukaryota" = "goldenrod4", "bacteria" = "darkolivegreen3")

category_colors <- c("viruses" = "#9b19f5", "eukaryota" = "#dc0ab4", "bacteria" = "#50e991")

domainabove$color <- value_to_color(domainabove$V2)
domain_color <- domainabove$color

# heatmap(amr62,
#         scale = "none",
#         Rowv = NA, 
#         Colv = NA, 
#         col=c("lightgrey", "steelblue4"),
#         cexCol = 0.8,
#         cexRow = 0.8,
#         width = 5,
#         height = 5,
#         RowSideColors = domainabove$color)

heatmap(amr62,
        scale = "none",
        Rowv = NA, 
        Colv = NA, 
        col=c("white", "#0d88e6"),
        cexCol = 0.8,
        cexRow = 0.8,
        width = 5,
        height = 5,
        RowSideColors = domainabove$color)

par(xpd = TRUE)  # Allow plotting outside plot region

# legend("bottomright", inset = c(-0.63, 0), legend = c("Viruses", "Eukaryota", "Bacteria", "Present", "Absent"), 
#        fill = c("red", "goldenrod4", "darkolivegreen3", "steelblue4", "lightgrey"), cex = 0.8, text.width = 0.6, bty = "n")

legend("bottomright", inset = c(-0.63, 0), legend = c("Viruses", "Eukaryota", "Bacteria", "Present", "Absent"), 
       fill = c("#9b19f5", "#dc0ab4", "#50e991", "#0d88e6", "white"), cex = 0.8, text.width = 0.6, bty = "n")

## Statistics for regimen
# Load necessary libraries
library(dplyr)
library(readr)

# Read the data from the uploaded file
file_path <- "~/cz_phicams/rr197_phicam_nextseq_dna_mngs_-_reupload_11711/extracted/pathogen/regime/allpresenceabs"
data <- read_csv(file_path, col_names = c("Pathogen", "HIV_Drug_Regimen"))

# Display the structure of the data
str(data)

# Perform descriptive statistics
pathogen_counts <- data %>%
  group_by(Pathogen) %>%
  summarise(Count = n())

regimen_counts <- data %>%
  group_by(HIV_Drug_Regimen) %>%
  summarise(Count = n())

# Print the descriptive statistics
print(pathogen_counts)
print(regimen_counts)

# Create a contingency table
contingency_table <- table(data$Pathogen, data$HIV_Drug_Regimen)

# Perform chi-squared test
chi_squared_test <- chisq.test(contingency_table)

# Perform Fisher's exact test (if applicable, for small sample sizes)
fisher_test <- fisher.test(contingency_table)

# Print the results of the statistical tests
print(chi_squared_test)
print(fisher_test)

library(vcd)

# Create a mosaic plot
mosaicplot(contingency_table, color = TRUE, main = "Mosaic Plot of Pathogen vs HIV Drug Regimen", las = 2)


## Pathobiome vs gender
patho_gend <- read.csv("~/cz_phicams/pathobiome/new.csv", header = T)

patho2 <- patho_gend %>% 
  group_by(Gender, Pathogen) %>% 
  dplyr::summarise(Count = n(), .groups = 'drop')
# amr2 <- amr %>% 
#   group_by(`Temperature category`, Pathogen) %>% 
#   dplyr::summarise(Count = n(), .groups = 'drop')

patho3 <- patho2 %>% 
  pivot_wider(names_from = Pathogen, values_from = Count)

patho3[is.na(patho3)] <- 0

data_long <- patho2 %>% 
  group_by(Pathogen) %>% 
  arrange(desc(Count)) %>% 
  ungroup()

gender_colors <- c("Female" = "#dc0ab4", "Male" = "#0bb4ff")

# Plot the stacked bar plot
p1 <- ggplot(data_long, aes(x = reorder(Pathogen, Count), y = Count, fill = Gender)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = gender_colors) +  # Use custom colors
  labs(x = "Pathogen", y = "Count", fill = "Gender") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for better readability
        axis.text.y = element_text(size = 6, hjust = 1),
        axis.text = element_text(size = 6),  # Reduce text size for axis labels
        legend.text = element_text(size = 6))  +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  scale_y_continuous(expand = c(0,0)) +
  coord_flip()

ggsave(filename = "gender.png", plot = p1, width = 8, height = 8)

jpeg(filename = "gender2.jpg", width = 800, height = 800)
plot(p1, main = "Gender")
dev.off()
# Pathogen vs mean age

patho_gend <- read.csv("~/cz_phicams/pathobiome/age_patho.csv", header = T)

patho2 <- patho_gend %>% 
  group_by(Mean_Age, Pathogen) %>% 
  dplyr::summarise(Count = n(), .groups = 'drop')
# amr2 <- amr %>% 
#   group_by(`Temperature category`, Pathogen) %>% 
#   dplyr::summarise(Count = n(), .groups = 'drop')

patho3 <- patho2 %>% 
  pivot_wider(names_from = Pathogen, values_from = Count)

patho3[is.na(patho3)] <- 0

data_long <- patho2 %>% 
  group_by(Pathogen) %>% 
  arrange(desc(Count)) %>% 
  ungroup()

gender_colors <- c("Below_Mean_Age" = "#50e991", "Equal_or_Above_Mean_Age" = "#0bb4ff")

# Plot the stacked bar plot
ggplot(data_long, aes(x = reorder(Pathogen, Count), y = Count, fill = Mean_Age)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = gender_colors) +  # Use custom colors
  labs(x = "Pathogen", y = "Count", fill = "Mean_Age") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for better readability
        axis.text.y = element_text(size = 6, hjust = 1),
        axis.text = element_text(size = 6),  # Reduce text size for axis labels
        legend.text = element_text(size = 6))  +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  scale_y_continuous(expand = c(0,0)) +
  coord_flip()



## uniqueness
# Install and load ggplot2 if not already installed
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
library(ggplot2)

# Define the data for unique pathogens
unique_pathogens <- data.frame(
  Drug_Combination = c(
    "ABC-3TC-DTG", "ABC-3TC-LPV", "AZT-3TC-DTG",
    "AZT-3TC-LPV", "Newly Diagnosed", "Sero Exposed",
    "TDF-3TC-DTG"
  ),
  Unique_Pathogens = c(10, 1, 4, 1, 7, 1, 7)
)

# Create the bar plot
ggplot(unique_pathogens, aes(x = Drug_Combination, y = Unique_Pathogens, fill = Drug_Combination)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Unique Pathogens in Each Drug Combination",
       x = "Drug Combinations",
       y = "Number of Unique Pathogens") +
  scale_fill_brewer(palette = "Set3") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

