# Load necessary libraries
library(ggplot2)
library(dplyr)

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

