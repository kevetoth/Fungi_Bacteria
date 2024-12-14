# Load necessary libraries
if (!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

# Calculate correlation matrix
correlation_matrix <- cor(Plant_param[ , -1], Soil_param[ , -1], use = "pairwise.complete.obs")

# Convert the correlation matrix to a long format
correlation_data <- as.data.frame(as.table(correlation_matrix))
colnames(correlation_data) <- c("Plant_Parameter", "Soil_Parameter", "Correlation")

# Correlogram with circles
correlogram <- ggplot(correlation_data, aes(x = Plant_Parameter, y = Soil_Parameter)) +
  geom_point(aes(size = abs(Correlation), color = Correlation)) +
  scale_color_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0, 
                        name = "Correlation") +
  scale_size_continuous(range = c(2, 10), name = "Strength\nof Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 12, face = "bold")) +
  labs(title = "Correlogram: Plant vs. Soil Parameters",
       x = "Plant Parameters",
       y = "Soil Parameters")

# Save correlogram to a file
ggsave("Correlogram_plant_vs_soil.pdf", plot = correlogram, width = 10, height = 8)





