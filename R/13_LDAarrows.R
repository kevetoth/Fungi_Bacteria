# Perform LDA for Plant Parameters
plant_lda <- lda(Group ~ ., data = Plant_param)

# Extract LDA coefficients (weights for each variable)
plant_coefficients <- plant_lda$scaling

# Convert coefficients to a data frame and calculate importance
plant_coefficients_df <- data.frame(
  Variable = rownames(plant_coefficients),
  LD1 = plant_coefficients[, 1],
  LD2 = plant_coefficients[, 2],
  Importance = rowSums(abs(plant_coefficients))  # Sum of absolute values for LD1 and LD2
)

# Filter out least important variables (set threshold, e.g., 0.1)
threshold <- 0.1
plant_coefficients_df <- subset(plant_coefficients_df, Importance > threshold)

# Create the plot with arrows for important variables only
plant_arrow_plot <- ggplot(plant_coefficients_df, aes(x = 0, y = 0)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Zero line for LD2
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Zero line for LD1
  geom_segment(aes(xend = LD1, yend = LD2), 
               arrow = arrow(type = "closed", length = unit(0.1, "inches")), 
               linewidth = 1) +  # Arrows for variables
  geom_text(aes(x = LD1, y = LD2, label = Variable), 
            color = "red", size = 3,  # Adjust font size for labels
            hjust = 1.5, vjust = 1.5) +  # Adjust label positions
  labs(title = "LDA Arrows for Plant Parameters (Filtered)", x = "LD1", y = "LD2") +
  theme_minimal() +
  theme(axis.text = element_text(color = "black"), 
        axis.title = element_text(size = 12),       
        axis.ticks = element_line(color = "black"))

# Save the plot
ggsave("Plant_LDA_Arrows.pdf", plot = plant_arrow_plot, width = 8, height = 6)


# Perform LDA for Soil Parameters
soil_lda <- lda(Group ~ ., data = Soil_param)

# Extract LDA coefficients (weights for each variable)
soil_coefficients <- soil_lda$scaling

# Convert coefficients to a data frame and calculate importance
soil_coefficients_df <- data.frame(
  Variable = rownames(soil_coefficients),
  LD1 = soil_coefficients[, 1],
  LD2 = soil_coefficients[, 2],
  Importance = rowSums(abs(soil_coefficients))  # Sum of absolute values for LD1 and LD2
)

# Filter out least important variables (set threshold, e.g., 0.1)
threshold <- 0.1
soil_coefficients_df <- subset(soil_coefficients_df, Importance > threshold)

# Create the plot with arrows for important variables only
soil_arrow_plot <- ggplot(soil_coefficients_df, aes(x = 0, y = 0)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +  # Zero line for LD2
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +  # Zero line for LD1
  geom_segment(aes(xend = LD1, yend = LD2), 
               arrow = arrow(type = "closed", length = unit(0.1, "inches")), 
               linewidth = 1) +  # Arrows for variables
  geom_text(aes(x = LD1, y = LD2, label = Variable), 
            color = "red", size = 3,  # Adjust font size for labels
            hjust = 1.5, vjust = 1.5) +  # Adjust label positions
  labs(title = "LDA Arrows for Soil Parameters (Filtered)", x = "LD1", y = "LD2") +
  theme_minimal() +
  theme(axis.text = element_text(color = "black"), 
        axis.title = element_text(size = 12),       
        axis.ticks = element_line(color = "black"))

# Save the plot
ggsave("Soil_LDA_Arrows.pdf", plot = soil_arrow_plot, width = 8, height = 6)


# Check if columns LD1 and LD2 exist in Plant_param and remove them
if ("LD1" %in% colnames(Plant_param)) {
  Plant_param <- Plant_param[, !colnames(Plant_param) %in% c("LD1", "LD2")]
}

# Check if columns LD1 and LD2 exist in Soil_param and remove them
if ("LD1" %in% colnames(Soil_param)) {
  Soil_param <- Soil_param[, !colnames(Soil_param) %in% c("LD1", "LD2")]
}

# Print a message to confirm removal
print("Columns 'LD1' and 'LD2' have been removed from both Plant_param and Soil_param.")
