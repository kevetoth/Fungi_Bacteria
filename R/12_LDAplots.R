# Load necessary library
library(MASS)

# Ensure 'Group' is a factor
Plant_param$Group <- as.factor(Plant_param$Group)

# Perform LDA
plant_lda <- lda(Group ~ ., data = Plant_param)

# View LDA results
print(plant_lda)

# Predict group memberships and extract scores
plant_predictions <- predict(plant_lda)

# Add LDA scores to the original data for plotting
Plant_param$LD1 <- plant_predictions$x[, 1]
Plant_param$LD2 <- plant_predictions$x[, 2]

# Plot LDA results
library(ggplot2)
plant_param_lda <- ggplot(Plant_param, aes(x = LD1, y = LD2, color = Group, fill = Group)) +
  geom_point(size = 3) +
  stat_ellipse(geom = "polygon", alpha = 0.3) + # Ellipses with transparent fill
  labs(title = "LDA Plot for Plant Parameters", x = "LD1", y = "LD2") +
  theme_minimal() +
  theme(legend.title = element_blank())

ggsave("Plant_LDA_Plot.pdf", plot = plant_param_lda, width = 8, height = 6)


# Ensure 'Group' is a factor
Soil_param$Group <- as.factor(Soil_param$Group)

# Perform LDA
soil_lda <- lda(Group ~ ., data = Soil_param)

# View LDA results
print(soil_lda)

# Predict group memberships and extract scores
soil_predictions <- predict(soil_lda)

# Add LDA scores to the original data for plotting
Soil_param$LD1 <- soil_predictions$x[, 1]
Soil_param$LD2 <- soil_predictions$x[, 2]

# Plot LDA results
soil_param_lda <- ggplot(Soil_param, aes(x = LD1, y = LD2, color = Group, fill = Group)) +
  geom_point(size = 3) +
  stat_ellipse(geom = "polygon", alpha = 0.3) + # Ellipses with transparent fill
  labs(title = "LDA Plot for Soil Parameters", x = "LD1", y = "LD2") +
  theme_minimal() +
  theme(legend.title = element_blank())

ggsave("Soil_LDA_Plot.pdf", plot = soil_param_lda, width = 8, height = 6)

# Inspect coefficients (scaling) for each LD
plant_lda_scaling <- plant_lda$scaling

# View the coefficients for LD1 and LD2
print(plant_lda_scaling)

# Inspect coefficients (scaling) for each LD
soil_lda_scaling <- soil_lda$scaling

# View the coefficients for LD1 and LD2
print(soil_lda_scaling)
