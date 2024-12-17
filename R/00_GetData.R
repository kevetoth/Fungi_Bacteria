# Load necessary libraries
if (!require(readxl)) install.packages("readxl")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(factoextra)) install.packages("factoextra")
if (!require(caret)) install.packages("caret")

library(ggplot2)
library(dplyr)
library(readxl)
library(caret)
library(MASS)

# download.file("https://dfzljdn9uc3pi.cloudfront.net/2022/13080/1/data.xlsx", "Plant_soil.xlsx", mode = "wb")

plant_soil <- read_excel("Plant_soil.xlsx")
colnames(plant_soil)[1] <- "Group"
colnames(plant_soil)[2] <- "Aboveground_Biomass"
colnames(plant_soil)[3] <- "Belowground_Biomass"
colnames(plant_soil)[4] <- "Total_Biomass"
colnames(plant_soil)[5] <- "RootLength"
colnames(plant_soil)[11] <- "R/S_ratio"
colnames(plant_soil)[15] <- "Total_N"
colnames(plant_soil)[16] <- "Total_C"
colnames(plant_soil)[17] <- "Available_P"
colnames(plant_soil)[18] <- "Total_P"
colnames(plant_soil)[23] <- "Plant_P"
colnames(plant_soil)[24] <- "Plant_N"
colnames(plant_soil)[25] <- "Plant_C"



plant_soil$Group <- as.character(plant_soil$Group)  # Convert the column to character if it's numeric
plant_soil$Group[plant_soil$Group == 1] <- "CK1"
plant_soil$Group[plant_soil$Group == 2] <- "A2"
plant_soil$Group[plant_soil$Group == 3] <- "B3"
plant_soil$Group[plant_soil$Group == 5] <- "AB5"
plant_soil$Group <- as.factor(plant_soil$Group)

# Replace `Root Length` with the actual column name for root length
if ("RootLength" %in% colnames(plant_soil) && "Belowground_Biomass" %in% colnames(plant_soil)) {
  
# Calculate Specific Root Length (SRL)
  plant_soil <- plant_soil %>%
    mutate(SRL = (`RootLength`/100) / `Belowground_Biomass`)
  
# View the updated dataframe
  print(head(plant_soil))
  
# Summary of SRL
  print(summary(plant_soil$SRL))
  
} 
  print(plant_soil)

