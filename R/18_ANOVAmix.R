# Load necessary libraries
library(ggplot2)
library(dplyr)
library(gridExtra)

# Assume `plant_soil` is your dataframe
# Rename the grouping column for convenience (if not already done)
colnames(plant_soil)[1] <- "Group"

# Reorder the factor levels of the "Group" column
desired_order <- c("CK1", "B3", "A2", "AB5")
plant_soil$Group <- factor(plant_soil$Group, levels = desired_order)

# Specify the PDF file name
pdf("Significant_ANOVA_mix.pdf", height = 12, width = 12)  # Adjust size to fit grid

# Get the names of all response variables (excluding the grouping column)
response_vars <- colnames(plant_soil)[2:ncol(plant_soil)]  # Adjust as needed

# Initialize an empty list to store plots
plot_list <- list()

# Iterate over each response variable to perform ANOVA and plot
for (var in response_vars) {
  # Perform ANOVA
  formula <- as.formula(paste("`", var, "` ~ Group", sep = ""))
  anova_result <- aov(formula, data = plant_soil)
  anova_summary <- summary(anova_result)
  
  # Extract p-value
  p_value <- anova_summary[[1]]$`Pr(>F)`[1]
  
  # Only generate plots for significant results
  if (p_value < 0.05) {
    # Visualization using ggplot2
    p <- ggplot(plant_soil, aes_string(x = "Group", y = paste0("`", var, "`"), fill = "Group")) +
      geom_boxplot() +
      theme_minimal() +
      labs(title = paste("Boxplot of", var, "Across Groups"),
           x = "Group",
           y = var) +
      # Dynamically set the y-position for the p-value annotation
      annotate("text", x = 1.5, y = min(plant_soil[[var]], na.rm = TRUE) - 0.5, 
               label = paste("p =", signif(p_value, digits = 3)), 
               hjust = 0, vjust = 1, size = 3, color = "red") +  # Moved p-value lower
      theme(plot.title = element_text(size = 7),  # Smaller title size
            axis.title = element_text(size = 7),   # Axis title size (optional)
            axis.text = element_text(size = 5))    # Axis labels size (optional)
    
    # Append the plot to the plot list
    plot_list <- c(plot_list, list(p))
  }
}

# Combine all the plots into a 4x4 grid (adjust the number of rows/columns as necessary)
if (length(plot_list) > 0) {
  do.call(grid.arrange, c(plot_list, ncol = 4))  # Adjust ncol for layout
}

# Close the PDF device
dev.off()

print("Significant_ANOVA_mix.pdf")
