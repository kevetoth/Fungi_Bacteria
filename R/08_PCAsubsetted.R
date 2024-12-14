# Load necessary libraries
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(factoextra)) install.packages("factoextra")

library(ggplot2)
library(factoextra)

# Normalize function: divide each column by its standard deviation
normalize <- function(df) {
  numeric_cols <- sapply(df, is.numeric)  # Identify numeric columns
  df[, numeric_cols] <- scale(df[, numeric_cols], center = FALSE, scale = TRUE)  # Divide by SD
  return(df)
}

# Normalize subsets (excluding 'Group' column)
Plant_param_normalized <- normalize(Plant_param[ , -1])  # Exclude 'Group' for normalization
Soil_param_normalized <- normalize(Soil_param[ , -1])    # Exclude 'Group' for normalization

# Add the 'Group' column back
Plant_param_normalized$Group <- Plant_param$Group
Soil_param_normalized$Group <- Soil_param$Group

# Perform PCA for Plant_param
pca_plant <- prcomp(Plant_param_normalized[ , -ncol(Plant_param_normalized)], center = TRUE, scale. = FALSE)

# Perform PCA for Soil_param
pca_soil <- prcomp(Soil_param_normalized[ , -ncol(Soil_param_normalized)], center = TRUE, scale. = FALSE)

# Scree plot for Plant_param
scree_plant <- fviz_eig(pca_plant, addlabels = TRUE, 
                        main = "Scree Plot for Plant Parameters", 
                        xlab = "Principal Components", 
                        ylab = "Variance Explained (%)")
print(scree_plant)
# Scree plot for Soil_param
scree_soil <- fviz_eig(pca_soil, addlabels = TRUE, 
                       main = "Scree Plot for Soil Parameters", 
                       xlab = "Principal Components", 
                       ylab = "Variance Explained (%)")
print(scree_soil)
# Save scree plots to PDF
ggsave("Scree_Plot_Plant_Param.pdf", plot = scree_plant, width = 8, height = 6)
ggsave("Scree_Plot_Soil_Param.pdf", plot = scree_soil, width = 8, height = 6)





# ggplot have to add % each pc is responsible for and ellipses when pulling getting error fix error


pca_plantdf <- as.data.frame(pca_plant$x)  # Extract PCA scores
pca_plantdf$Group <- plant_soil$Group

# Calculate variance explained by PC1 and PC2
explained_variance <- summary(pca_plant)$importance[2, 1:2] * 100  # Extract variance percentages
pc1_label <- paste0("Principal Component 1 (", round(explained_variance[1], 2), "%)")
pc2_label <- paste0("Principal Component 2 (", round(explained_variance[2], 2), "%)")

# PCA Plot with Smaller Ellipses
pca_plant_scatter <- ggplot(pca_plantdf, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3, alpha = 0.8) +  # Scatter points
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Horizontal line at 0
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Vertical line at 0
  stat_ellipse(type = "norm", geom = "polygon", alpha = 0.2, aes(fill = Group), 
               level = 0.8, show.legend = FALSE) +  # Adjusted ellipses with smaller confidence level
  labs(title = "PCA of Plant Parameters with Treatment Groups", 
       x = pc1_label, 
       y = pc2_label) +
  theme_minimal() +
  theme(legend.position = "right")

# Save PCA Plant plot with smaller ellipses
ggsave("PCA_Plant.pdf", plot = pca_plant_scatter, width = 8, height = 6)


# Calculate percentage contribution for PC1 and PC2
explained_variance <- summary(pca_plant)$importance[2, ] * 100
pc1_label <- paste0("Principal Component 1 (", round(explained_variance[1], 2), "%)")
pc2_label <- paste0("Principal Component 2 (", round(explained_variance[2], 2), "%)")

# Prepare PCA DataFrame for plant_soil
pca_soildf <- as.data.frame(pca_soil$x)  # Extract PCA scores
pca_soildf$Group <- plant_soil$Group

# PCA Plot with Smaller Ellipses for plant_soil
pca_soil_scatter <- ggplot(pca_soildf, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3, alpha = 0.8) +  # Scatter points
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Horizontal line at 0
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Vertical line at 0
  stat_ellipse(type = "norm", geom = "polygon", alpha = 0.2, aes(fill = Group), 
               level = 0.8, show.legend = FALSE) +  # Adjusted ellipses with smaller confidence level
  labs(title = "PCA of Soil Parameters with Treatment Groups", 
       x = pc1_label, 
       y = pc2_label) +
  theme_minimal() +
  theme(legend.position = "right")

# Save PCA Soil plot with smaller ellipses
ggsave("PCA_Soil.pdf", plot = pca_soil_scatter, width = 8, height = 6)



# Loadings for PCA of Plant_param
loadings_plant <- as.data.frame(pca_plant$rotation)

# Calculate percentage contribution for PC1 and PC2
explained_variance_plant <- summary(pca_plant)$importance[2, ] * 100
pc1_label_plant <- paste0("Principal Component 1 (", round(explained_variance_plant[1], 2), "%)")
pc2_label_plant <- paste0("Principal Component 2 (", round(explained_variance_plant[2], 2), "%)")

# Create a dataframe for arrows
arrows_plant <- data.frame(
  x = 0,  # Origin x
  y = 0,  # Origin y
  xend = loadings_plant[, 1],  # PC1 Loadings
  yend = loadings_plant[, 2],  # PC2 Loadings
  Variables = rownames(loadings_plant)  # Variable names
)

# PCA plot with arrows for Plant_param
pca_plant_arrows <- ggplot() +
  geom_segment(data = arrows_plant, aes(x = x, y = y, xend = xend, yend = yend),
               arrow = arrow(length = unit(0.2, "cm")), color = "blue") +
  geom_text(data = arrows_plant, aes(x = xend, y = yend, label = Variables),
            hjust = 1.1, vjust = 1.1, size = 4, color = "red") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Horizontal line at 0
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Vertical line at 0
  labs(title = "PCA Plot of Plant Parameters (Loadings Only)",
       x = pc1_label_plant, 
       y = pc2_label_plant) +
  theme_minimal()

# Save PCA arrows plot for Plant_param
ggsave("PCA_Plant_loadings.pdf", plot = pca_plant_arrows, width = 8, height = 6)


# Loadings for PCA of Soil_param
loadings_soil <- as.data.frame(pca_soil$rotation)

# Calculate percentage contribution for PC1 and PC2
explained_variance_soil <- summary(pca_soil)$importance[2, ] * 100
pc1_label_soil <- paste0("Principal Component 1 (", round(explained_variance_soil[1], 2), "%)")
pc2_label_soil <- paste0("Principal Component 2 (", round(explained_variance_soil[2], 2), "%)")

# Create a dataframe for arrows
arrows_soil <- data.frame(
  x = 0,  # Origin x
  y = 0,  # Origin y
  xend = loadings_soil[, 1],  # PC1 Loadings
  yend = loadings_soil[, 2],  # PC2 Loadings
  Variables = rownames(loadings_soil)  # Variable names
)

# PCA plot with arrows for Soil_param
pca_soil_arrows <- ggplot() +
  geom_segment(data = arrows_soil, aes(x = x, y = y, xend = xend, yend = yend),
               arrow = arrow(length = unit(0.2, "cm")), color = "blue") +
  geom_text(data = arrows_soil, aes(x = xend, y = yend, label = Variables),
            hjust = 1.1, vjust = 1.1, size = 4, color = "red") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Horizontal line at 0
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Vertical line at 0
  labs(title = "PCA Plot of Soil Parameters (Loadings Only)",
       x = pc1_label_soil, 
       y = pc2_label_soil) +
  theme_minimal()

# Save PCA arrows plot for Soil_param
ggsave("PCA_Soil_loadings.pdf", plot = pca_soil_arrows, width = 8, height = 6)




# Extract the loadings for Plant_param PCA
loadings_plant <- as.data.frame(pca_plant$rotation)

# Create a dataframe for the first three PCs
loadings_plantdf <- data.frame(
  Variables = rownames(loadings_plant),
  PC1 = loadings_plant[, 1],
  PC2 = loadings_plant[, 2],
  PC3 = loadings_plant[, 3]
)

# Add absolute values for sorting
loadings_plantdf <- loadings_plantdf %>%
  mutate(Abs_PC1 = abs(PC1),
         Abs_PC2 = abs(PC2),
         Abs_PC3 = abs(PC3))

# Sort by absolute values of PC1, PC2, or PC3
sorted_loadings_plant <- loadings_plantdf %>%
  arrange(desc(Abs_PC1))  # Change to Abs_PC2 or Abs_PC3 for other PCs

# Print sorted loadings for Plant_param PCA
print("Top contributing variables to PC1 (Plant_param):")
print(sorted_loadings_plant)

# Extract the loadings for Soil_param PCA
loadings_soil <- as.data.frame(pca_soil$rotation)

# Create a dataframe for the first three PCs
loadings_soildf <- data.frame(
  Variables = rownames(loadings_soil),
  PC1 = loadings_soil[, 1],
  PC2 = loadings_soil[, 2],
  PC3 = loadings_soil[, 3]
)

# Add absolute values for sorting
loadings_soildf <- loadings_soildf %>%
  mutate(Abs_PC1 = abs(PC1),
         Abs_PC2 = abs(PC2),
         Abs_PC3 = abs(PC3))

# Sort by absolute values of PC1, PC2, or PC3
sorted_loadings_soil <- loadings_soildf %>%
  arrange(desc(Abs_PC1))  # Change to Abs_PC2 or Abs_PC3 for other PCs

# Print sorted loadings for Soil_param PCA
print("Top contributing variables to PC1 (Soil_param):")
print(sorted_loadings_soil)







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


