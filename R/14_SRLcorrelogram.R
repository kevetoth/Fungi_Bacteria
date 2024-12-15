# Load required libraries
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(reshape2)) install.packages("reshape2")
library(ggplot2)
library(reshape2)

# Extract SRL (Specific Root Length)
SRL <- Plant_param$SRL

# Exclude SRL column and retain only numeric columns from Plant parameters
Plant_param_no_srl <- Plant_param[, !names(Plant_param) %in% "SRL"]
Plant_param_no_srl <- Plant_param_no_srl[sapply(Plant_param_no_srl, is.numeric)]  # Retain only numeric columns

# Exclude SRL column and retain only numeric columns from Soil parameters
Soil_param_numeric <- Soil_param[sapply(Soil_param, is.numeric)]  # Retain only numeric columns

# Prepare data for correlogram: SRL vs Plant parameters
plant_corr <- sapply(Plant_param_no_srl, function(x) cor(SRL, x, use = "complete.obs"))
plant_corr_df <- data.frame(Variable = names(plant_corr), Correlation = plant_corr)
plant_corr_df <- plant_corr_df[order(plant_corr_df$Correlation, decreasing = TRUE), ]

# Prepare data for correlogram: SRL vs Soil parameters
soil_corr <- sapply(Soil_param_numeric, function(x) cor(SRL, x, use = "complete.obs"))
soil_corr_df <- data.frame(Variable = names(soil_corr), Correlation = soil_corr)
soil_corr_df <- soil_corr_df[order(soil_corr_df$Correlation, decreasing = TRUE), ]

# Plot 1: SRL vs Plant parameters
plot1 <- ggplot(plant_corr_df, aes(x = Variable, y = "SRL", fill = Correlation, size = abs(Correlation))) +
  geom_point(shape = 21, color = "black") +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0, limits = c(-1, 1)) +
  scale_size_continuous(range = c(3, 8)) +
  labs(title = "Correlation: SRL vs Plant Parameters",
       x = "Plant Parameters", y = NULL, fill = "Correlation", size = "Strength") +
  theme_minimal(base_size = 10) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
    axis.title.x = element_text(size = 10, margin = margin(t = 5)),
    plot.margin = margin(5, 5, 5, 5)
  )

# Plot 2: SRL vs Soil parameters
plot2 <- ggplot(soil_corr_df, aes(x = Variable, y = "SRL", fill = Correlation, size = abs(Correlation))) +
  geom_point(shape = 21, color = "black") +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0, limits = c(-1, 1)) +
  scale_size_continuous(range = c(3, 8)) +
  labs(title = "Correlation: SRL vs Soil Parameters",
       x = "Soil Parameters", y = NULL, fill = "Correlation", size = "Strength") +
  theme_minimal(base_size = 10) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
    axis.title.x = element_text(size = 10, margin = margin(t = 5)),
    plot.margin = margin(5, 5, 5, 5)
  )

# Save both plots to a single PDF
pdf("SRL_Correlogram.pdf", width = 6, height = 4)  # Smaller plot dimensions
print(plot1)
print(plot2)
dev.off()


