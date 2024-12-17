# Load necessary libraries
library(ggplot2)
library(dplyr)

# Assume `plant_soil` is your dataframe
# Rename the grouping column for convenience (if not already done)
colnames(plant_soil)[1] <- "Group"

# Filter the dataframe to keep only rows with groups A2 and AB5
filtered_data <- plant_soil %>% filter(Group %in% c("A2", "AB5"))

# Reorder the factor levels for the filtered groups
filtered_data$Group <- factor(filtered_data$Group, levels = c("A2", "AB5"))

# Get the names of all response variables (excluding the grouping column)
response_vars <- colnames(filtered_data)[2:ncol(filtered_data)]  # Adjust as needed

# Specify the PDF file name
pdf("Significant_ANOVA_Fungivsbacteria.pdf")

# Iterate over each response variable to perform ANOVA and plot
for (var in response_vars) {
  # Perform ANOVA
  formula <- as.formula(paste("`", var, "` ~ Group", sep = ""))
  anova_result <- aov(formula, data = filtered_data)
  anova_summary <- summary(anova_result)
  
  # Extract p-value
  p_value <- anova_summary[[1]]$`Pr(>F)`[1]
  
  # Check if p-value is less than 0.05
  if (p_value < 0.05) {
    # Create the boxplot
    p <- ggplot(filtered_data, aes_string(x = "Group", y = paste0("`", var, "`"), fill = "Group")) +
      geom_boxplot() +
      theme_minimal() +
      labs(title = paste("Significant Boxplot of", var, "Between A2 and AB5"),
           x = "Group",
           y = var) +
      annotate("text", x = 1.5, y = max(filtered_data[[var]], na.rm = TRUE), 
               label = paste("p =", signif(p_value, digits = 3)), 
               hjust = 0, vjust = -0.5, size = 5, color = "red")
    
    # Print the plot (this writes it to the PDF)
    print(p)
  }
}

# Close the PDF device
dev.off()

print("Plots saved to Significant_ANOVA_fungivsbacteria.pdf")

