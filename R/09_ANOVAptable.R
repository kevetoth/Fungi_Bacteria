# Filter numeric variables for ANOVA
response_vars <- colnames(plant_soil)[sapply(plant_soil, is.numeric) & colnames(plant_soil) != "Group"]

# Initialize a dataframe to store ANOVA results
anova_results <- data.frame(Variable = character(), P_Value = numeric(), stringsAsFactors = FALSE)

# Perform ANOVA for each numeric variable
for (var in response_vars) {
  formula <- as.formula(paste("`", var, "` ~ Group", sep = ""))
  anova_result <- aov(formula, data = plant_soil)
  anova_summary <- summary(anova_result)
  
  # Extract p-value
  p_value <- anova_summary[[1]]$`Pr(>F)`[1]
  anova_results <- rbind(anova_results, data.frame(Variable = var, P_Value = p_value))
}

# Apply Bonferroni correction
anova_results$Bonferroni_P <- p.adjust(anova_results$P_Value, method = "bonferroni")

# Save ANOVA results to a CSV file
write.csv(anova_results, "ANOVA_Results.csv", row.names = FALSE)

# Display the results
print("ANOVA Results with Bonferroni Correction:")
print(anova_results)
