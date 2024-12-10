# Subset 1: Plant parameters (including 'Group' as the treatment column)
Plant_param <- plant_soil[, c("Group", "Aboveground_Biomass", "Belowground_Biomass", "Total_Biomass", 
                              "RootLength", "RootSurfaceArea", "RootAverageDiameter", "Rvolume", 
                              "Rootbranches", "SIZE", "R/S_ratio", "HEIGHT", 
                              "Plant_P", "Plant_N", "Plant_C", "SRL")]

# Subset 2: Soil parameters (including 'Group' as the treatment column)
Soil_param <- plant_soil[, c("Group", "NH4+-N", "NO3-N", "Total_N", "Total_C", 
                             "Available_P", "Total_P", "ALP", "UE", "EC", "PH")]

# View the subsets (optional)
head(Plant_param)
head(Soil_param)

# Save the subsets to new dataframes if needed
write.csv(Plant_param, "Plant_param.csv", row.names = FALSE)
write.csv(Soil_param, "Soil_param.csv", row.names = FALSE)
