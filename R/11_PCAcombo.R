# Combine PCA data for plotting
pca_combined <- data.frame(
  Plant_PC1 = pca_plant$x[, 1],  # PC1 of Plant parameters
  Soil_PC1 = pca_soil$x[, 1],    # PC1 of Soil parameters
  Group = plant_soil$Group       # Group information (from the dataset)
)

pca_scatter <- ggplot(pca_combined, aes(x = Plant_PC1, y = Soil_PC1, color = Group)) +
  geom_point(size = 3, alpha = 0.8) +  # Scatter points
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Horizontal line at 0
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Vertical line at 0
  stat_ellipse(type = "norm", geom = "polygon", alpha = 0.2, 
               aes(fill = Group), level = 0.8, show.legend = FALSE) +  # Same fill as dots
  labs(title = "PCA Scatter Plot: PC1 of Plant vs PC1 of Soil",
       x = "Plant PC1",
       y = "Soil PC1") +
  theme_minimal() +
  theme(legend.position = "right",
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 12, face = "bold")) +
  scale_color_brewer(palette = "Set2") +  # Adjust color palette if needed
  scale_fill_brewer(palette = "Set2")  # Ensure the fill of the ellipse matches the color of the dots

# Save the scatter plot to a PDF
ggsave("PCA_Scatter_PlantPC1_vs_SoilPC1.pdf", plot = pca_scatter, width = 8, height = 6)


