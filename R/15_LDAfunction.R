# Load necessary libraries
library(MASS)
library(ggplot2)
library(dplyr)  # For data manipulation

# Define the LDA function with the update
perform_lda <- function(data, group_col, threshold = 0.1, plot_title_prefix = "") {
  # Standardize the data
  predictors <- setdiff(names(data), group_col)
  data_std <- data
  data_std[, predictors] <- scale(data[, predictors])
  data_std[[group_col]] <- as.factor(data_std[[group_col]])
  
  # Perform LDA
  lda_model <- lda(as.formula(paste(group_col, "~ .")), data = data_std)
  
  # Predictions and LDA scores
  predictions <- predict(lda_model)
  data_std$LD1 <- predictions$x[, 1]
  data_std$LD2 <- predictions$x[, 2]
  
  # Plot LDA results
  lda_plot <- ggplot(data_std, aes(x = LD1, y = LD2, color = !!sym(group_col), fill = !!sym(group_col))) +
    geom_point(size = 3, alpha = 0.7) +
    stat_ellipse(geom = "polygon", alpha = 0.3) +
    labs(title = paste(plot_title_prefix, "LDA Plot"), x = "LD1", y = "LD2") +
    theme_minimal() +
    theme(legend.title = element_blank())
  print(lda_plot)  # Print LDA plot to the R graphics device
  
  # Extract and filter variable importance
  coefficients <- lda_model$scaling
  coefficients_df <- data.frame(
    Variable = rownames(coefficients),
    LD1 = coefficients[, 1],
    LD2 = coefficients[, 2],
    Importance = rowSums(abs(coefficients))
  )
  
  # Filter for importance threshold
  coefficients_filtered <- coefficients_df %>%
    filter(Importance > threshold)
  
  # Plot variable importance arrows
  arrow_plot <- ggplot(coefficients_filtered, aes(x = 0, y = 0)) +
    geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Zero line for LD2
    geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Zero line for LD1
    geom_segment(aes(xend = LD1, yend = LD2), 
                 arrow = arrow(type = "closed", length = unit(0.1, "inches")), 
                 linewidth = 1) +  # Arrows for variables
    geom_text(aes(x = LD1, y = LD2, label = Variable), color = "red", size = 3, hjust = 1.5, vjust = 1.5) +
    labs(title = paste(plot_title_prefix, "Variables Affecting LDA"),
         x = "LD1", y = "LD2") +
    theme_minimal() +
    theme(axis.text = element_text(color = "black"), 
          axis.title = element_text(size = 12),       
          axis.ticks = element_line(color = "black"))
  print(arrow_plot)  # Print arrow plot to the R graphics device
  
  # Return results
  return(list(lda_model = lda_model, predictions = predictions, lda_plot = lda_plot, arrow_plot = arrow_plot))
}

