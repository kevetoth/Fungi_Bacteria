# Load necessary libraries
library(ggplot2)

# Assuming 'plant_soil' is your original dataframe
# Subset numeric columns
df_numeric <- plant_soil[, sapply(plant_soil, is.numeric)]


# Fit an exponential model: UE = a * exp(b * Plant_P)
exp_model <- nls(UE ~ a * exp(b * Plant_P), data = df_numeric, start = list(a = 400, b = -10))

# Extract model coefficients
coeffs <- coef(exp_model)
a <- round(coeffs["a"], 2)
b <- round(coeffs["b"], 4)

# Predict values for the curve
df_numeric$Predicted_UE <- predict(exp_model)

# Calculate pseudo-R²
RSS <- sum((df_numeric$UE - df_numeric$Predicted_UE)^2) # Residual sum of squares
TSS <- sum((df_numeric$UE - mean(df_numeric$UE))^2)     # Total sum of squares
pseudo_R2 <- 1 - (RSS / TSS)                            # Pseudo-R²

# Construct the formula string to display
formula_text <- paste0("UE = ", a, " * exp(", b, " * Plant_P)")
pseudoR2_text <- paste0("Pseudo-R² = ", round(pseudo_R2, 3))

# Plot the data with the exponential curve, formula, and pseudo-R²
ggplot(df_numeric, aes(x = Plant_P, y = UE)) +
  geom_point(color = "blue", alpha = 0.6, size = 2) +
  geom_line(aes(y = Predicted_UE), color = "red", size = 1) +
  annotate("text", x = max(df_numeric$Plant_P) * 0.4, y = max(df_numeric$UE) * 0.9,
           label = formula_text, size = 5, color = "black", hjust = 0) +
  annotate("text", x = max(df_numeric$Plant_P) * 0.6, y = max(df_numeric$UE) * 0.8,
           label = pseudoR2_text, size = 5, color = "black", hjust = 0) +
  labs(title = "Exponential Model: UE vs Plant_P",
       x = "Plant_P", y = "UE") +
  theme_minimal()

