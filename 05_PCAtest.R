# Install necessary packages if not already installed
if (!require(readxl)) install.packages("readxl")
if (!require(ggplot2)) install.packages("ggplot2")

# Load the packages
library(readxl)
library(ggplot2)

# Load your Excel file
file_path <- "Plant_soil.xlsx"  # Replace this with the correct path to your file
data <- read_excel(file_path)

# View the data to check its structure
head(data)

# Preprocess: Keep only numeric columns and scale the data
numeric_data <- data[, sapply(data, is.numeric)]  # Select only numeric columns
scaled_data <- scale(numeric_data)  # Standardize the data

# Perform PCA
pca_result <- prcomp(scaled_data, center = TRUE, scale. = TRUE)

# Summary of PCA
summary(pca_result)

# Scree plot: Explained variance
pca_variance <- pca_result$sdev^2
pca_variance_ratio <- pca_variance / sum(pca_variance)
plot(pca_variance_ratio, type = "b",
     main = "Scree Plot", xlab = "Principal Components", ylab = "Variance Explained")

# Biplot of PCA
biplot(pca_result, scale = 0)

# Visualize PCA results using ggplot2
pca_df <- as.data.frame(pca_result$x)  # Principal components

# Scatterplot of first two principal components
ggplot(pca_df, aes(x = PC1, y = PC2)) +
  geom_point(size = 2, color = "blue") +
  labs(title = "PCA Plot", x = "Principal Component 1", y = "Principal Component 2") +
  theme_minimal()
# Install necessary packages if not already installed
if (!require(readxl)) install.packages("readxl")
if (!require(ggplot2)) install.packages("ggplot2")

# Load the packages
library(readxl)
library(ggplot2)

# Load your Excel file
file_path <- "Plant_soil.xlsx"  # Replace this with the correct path to your file
data <- read_excel(file_path)

# Preprocess: Keep only numeric columns and scale the data
numeric_data <- data[, sapply(data, is.numeric)]  # Select only numeric columns
scaled_data <- scale(numeric_data)  # Standardize the data

# Perform PCA
pca_result <- prcomp(scaled_data, center = TRUE, scale. = TRUE)

# Scree plot: Explained variance
pca_variance <- pca_result$sdev^2
pca_variance_ratio <- pca_variance / sum(pca_variance)

# Prepare PCA data for ggplot
pca_df <- as.data.frame(pca_result$x)  # Principal components

# Open a PDF device to save plots
pdf("PCA_Plots.pdf")

# Plot 1: Scree Plot
plot(pca_variance_ratio, type = "b",
     main = "Scree Plot", xlab = "Principal Components", ylab = "Variance Explained")

# Plot 2: Biplot
biplot(pca_result, scale = 0)

# Plot 3: PCA Scatterplot (First Two Components)
ggplot(pca_df, aes(x = PC1, y = PC2)) +
  geom_point(size = 2, color = "blue") +
  labs(title = "PCA Plot", x = "Principal Component 1", y = "Principal Component 2") +
  theme_minimal()

# Close the PDF device
dev.off()

cat("PCA plots saved to PCA_Plots.pdf in your working directory.\n")


