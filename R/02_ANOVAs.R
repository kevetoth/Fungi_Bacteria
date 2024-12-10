# Load necessary libraries
library(ggplot2)
library(dplyr)

# Assume `plant_soil` is your dataframe
# Rename the grouping column for convenience (if not already done)
colnames(plant_soil)[1] <- "Group"

# Reorder the factor levels of the "Group" column
desired_order <- c("CK1", "B3", "A2", "AB5")
plant_soil$Group <- factor(plant_soil$Group, levels = desired_order)

# Specify the PDF file name
pdf("ANOVA_Boxplots.pdf")

# Get the names of all response variables (excluding the grouping column)
response_vars <- colnames(plant_soil)[2:ncol(plant_soil)]  # Adjust as needed

# Iterate over each response variable to perform ANOVA and plot
for (var in response_vars) {
  # Perform ANOVA
  formula <- as.formula(paste("`", var, "` ~ Group", sep = ""))
  anova_result <- aov(formula, data = plant_soil)
  anova_summary <- summary(anova_result)
  
  # Extract p-value
  p_value <- anova_summary[[1]]$`Pr(>F)`[1]
  
  # Visualization using ggplot2
  p <- ggplot(plant_soil, aes_string(x = "Group", y = paste0("`", var, "`"), fill = "Group")) +
    geom_boxplot() +
    theme_minimal() +
    labs(title = paste("Boxplot of", var, "Across Groups"),
         x = "Group",
         y = var) +
    annotate("text", x = 1.5, y = max(plant_soil[[var]], na.rm = TRUE), 
             label = paste("p =", signif(p_value, digits = 3)), 
             hjust = 0, vjust = -0.5, size = 5, color = "red")
  
  # Print the plot (this writes it to the PDF)
  print(p)
}

# Close the PDF device
dev.off()

print("Plots saved to ANOVA_Boxplots.pdf")

