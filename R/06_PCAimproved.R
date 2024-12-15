# Load necessary libraries
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(factoextra)) install.packages("factoextra")

library(ggplot2)
library(factoextra)

# Preprocess: Keep only numeric columns (excluding 'Group') and scale the data
numeric_data <- plant_soil[, sapply(plant_soil, is.numeric)]  # Select only numeric columns
scaled_data <- scale(numeric_data)  # Standardize the data

# Perform PCA
pca_result <- prcomp(scaled_data, center = TRUE, scale. = TRUE)

# Scree plot: Explained variance
pca_variance <- pca_result$sdev^2
pca_variance_ratio <- pca_variance / sum(pca_variance)

# Create a dataframe for scree plot
scree_data <- data.frame(
  PrincipalComponent = factor(
    paste0("PC", 1:length(pca_variance_ratio)),
    levels = paste0("PC", 1:length(pca_variance_ratio))  # Ensure correct order
  ),
  VarianceExplained = pca_variance_ratio
)

# Plot the scree plot as a bar chart
scree_plot <- ggplot(scree_data, aes(x = PrincipalComponent, y = VarianceExplained)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  labs(title = "Scree Plot", 
       x = "Principal Component", 
       y = "Proportion of Variance Explained") +
  theme_minimal()
print(scree_plot)
# Save scree plot
ggsave("PCA_Scree_Plot.pdf", plot = scree_plot, width = 8, height = 6)

# Create PCA result dataframe with groups for coloring
pca_df <- as.data.frame(pca_result$x)  # Extract PCA scores
pca_df$Group <- plant_soil$Group  # Add group information from the 'Group' column

# Scatterplot of first two principal components with zero lines and group coloring
pca_scatter <- ggplot(pca_df, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3, alpha = 0.8) +  # Scatter points
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Horizontal line at 0
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Vertical line at 0
  labs(title = "PCA Plot", 
       x = "Principal Component 1", 
       y = "Principal Component 2") +
  theme_minimal() +
  theme(legend.position = "right")  # Adjust legend position

# Print the plots
print(scree_plot)
print(pca_scatter)

# Save PCA scatterplot
ggsave("PCA_Scatter_Plot.pdf", plot = pca_scatter, width = 8, height = 6)

