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

pca_plant_scatter <- ggplot(pca_plantdf, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3, alpha = 0.8) +  # Scatter points
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Horizontal line at 0
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Vertical line at 0
  labs(title = "PCA of Plant parameters with treatment groups", 
       x = "Principal Component 1", 
       y = "Principal Component 2") +
  theme_minimal() +
  theme(legend.position = "right") 
ggsave("PCA_Plant.pdf", plot = pca_plant_scatter, width = 8, height = 6)


pca_soildf <- as.data.frame(pca_soil$x)  # Extract PCA scores
pca_soildf$Group <- plant_soil$Group

pca_soil_scatter <- ggplot(pca_soildf, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3, alpha = 0.8) +  # Scatter points
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Horizontal line at 0
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Vertical line at 0
  labs(title = "PCA Plot of Soil parameters with treatment groups", 
       x = "Principal Component 1", 
       y = "Principal Component 2") +
  theme_minimal() +
  theme(legend.position = "right") 


ggsave("PCA_Soil.pdf", plot = pca_soil_scatter, width = 8, height = 6)
# Assuming `pca_result` is your PCA object
loadings_plant <- as.data.frame(pca_plant$rotation)

# Extract the loadings for PC1, PC2, and PC3
loadings_plantdf <- data.frame(
  Variables = rownames(loadings),
  PC1 = loadings[, 1],
  PC2 = loadings[, 2],
  PC3 = loadings[, 3]
)

# Add columns for absolute values
loadings_plantdf <- loadings_df %>%
  mutate(Abs_PC1 = abs(PC1),
         Abs_PC2 = abs(PC2),
         Abs_PC3 = abs(PC3))

# Sort by absolute values of PC1, PC2, or PC3
# You can change "Abs_PC1" to "Abs_PC2" or "Abs_PC3" to sort by those components
loadings_plantdf <- loadings_plantdf %>%
  arrange(desc(Abs_PC1)) %>%
  select(Variables, PC1, PC2, PC3)

# Assuming `pca_result` is your PCA object
loadings_soil <- as.data.frame(pca_soil$rotation)

# Extract the loadings for PC1, PC2, and PC3
loadings_soildf <- data.frame(
  Variables = rownames(loadings),
  PC1 = loadings[, 1],
  PC2 = loadings[, 2],
  PC3 = loadings[, 3]
)

# Add columns for absolute values
loadings_soildf <- loadings_soildf %>%
  mutate(Abs_PC1 = abs(PC1),
         Abs_PC2 = abs(PC2),
         Abs_PC3 = abs(PC3))

# Sort by absolute values of PC1, PC2, or PC3
# You can change "Abs_PC1" to "Abs_PC2" or "Abs_PC3" to sort by those components
loadings_soildf <- loadings_soildf %>%
  arrange(desc(Abs_PC1)) %>%
  select(Variables, PC1, PC2, PC3)

