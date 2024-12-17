# Fit an exponential decay model
exp_model <- nls(UE ~ a * exp(b * Plant_P), data = df_numeric, start = list(a = 400, b = -10))
summary(exp_model)

# Plot the non-linear fit
ggplot(df_numeric, aes(x = Plant_P, y = UE)) +
  geom_point(color = "blue", alpha = 0.6, size = 2) +
  geom_line(aes(y = predict(exp_model)), color = "purple", size = 1) +
  labs(title = "Exponential Fit: UE vs Plant_P", x = "Plant_P", y = "UE") +
  theme_minimal()




# Load libraries
library(ggplot2)

# Fit an exponential non-linear model
exp_model <- nls(UE ~ a * exp(b * Plant_P), data = df_numeric, start = list(a = 400, b = -10))

# Predict fitted values
df_numeric$Predicted_UE <- predict(exp_model)

# Calculate pseudo-R²
RSS <- sum((df_numeric$UE - df_numeric$Predicted_UE)^2) # Residual sum of squares
TSS <- sum((df_numeric$UE - mean(df_numeric$UE))^2)     # Total sum of squares
pseudo_R2 <- 1 - (RSS / TSS)                           # Pseudo-R²

# Plot with pseudo-R² on the graph
ggplot(df_numeric, aes(x = Plant_P, y = UE)) +
  geom_point(color = "blue", alpha = 0.6, size = 2) +
  geom_line(aes(y = Predicted_UE), color = "red", size = 1) +
  annotate("text", x = max(df_numeric$Plant_P) * 0.8, y = max(df_numeric$UE) * 0.9,
           label = paste("Pseudo-R² =", round(pseudo_R2, 3)), size = 5, color = "black") +
  labs(title = "Exponential Model: UE vs Plant_P")),
       x = "Plant_P", y = "UE") +
  theme_minimal()









# Load required libraries
library(ggplot2)

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
pseudo_R2 <- 1 - (RSS / TSS)                           # Pseudo-R²

# Construct the formula string to display
formula_text <- paste0("UE = ", a, " * exp(", b, " * Plant_P)")
pseudoR2_text <- paste0("Pseudo-R² = ", round(pseudo_R2, 3))

# Plot the data with the exponential curve, formula, and pseudo-R²
ggplot(df_numeric, aes(x = Plant_P, y = UE)) +
  geom_point(color = "blue", alpha = 0.6, size = 2) +
  geom_line(aes(y = Predicted_UE), color = "red", size = 1) +
  # Adjust x to move annotations further left
  annotate("text", x = max(df_numeric$Plant_P) * 0.4, y = max(df_numeric$UE) * 0.9,
           label = formula_text, size = 5, color = "black", hjust = 0) +
  annotate("text", x = max(df_numeric$Plant_P) * 0.6, y = max(df_numeric$UE) * 0.8,
           label = pseudoR2_text, size = 5, color = "black", hjust = 0) +
  labs(title = "Exponential Model: UE vs Plant_P",
       x = "Plant_P", y = "UE") +
  theme_minimal()
