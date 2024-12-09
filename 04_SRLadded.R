# Load necessary libraries
library(ggplot2)
library(dplyr)

# Replace `Root Length` with the actual column name for root length
if ("Root Length" %in% colnames(plant_soil) && "belowground biomass" %in% colnames(plant_soil)) {
  
  # Calculate Specific Root Length (SRL)
  plant_soil <- plant_soil %>%
    mutate(SRL = (`Root Length`/100) / `belowground biomass`)
  
  # View the updated dataframe
  print(head(plant_soil))
  
  # Summary of SRL
  print(summary(plant_soil$SRL))
  
} 

