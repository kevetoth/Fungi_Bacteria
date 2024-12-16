# Perform LDA for Plant Parameters
plant_lda_results <- perform_lda(Plant_param, "Group", threshold = 0.1, plot_title_prefix = "Plant Parameters")
ggsave("Plant_LDA_Plot.pdf", plot = plant_lda_results$lda_plot, width = 8, height = 6)
ggsave("Plant_LDA_Arrows.pdf", plot = plant_lda_results$arrow_plot, width = 8, height = 6)

# Perform LDA for Soil Parameters
soil_lda_results <- perform_lda(Soil_param, "Group", threshold = 0.1, plot_title_prefix = "Soil Parameters")
ggsave("Soil_LDA_Plot.pdf", plot = soil_lda_results$lda_plot, width = 8, height = 6)
ggsave("Soil_LDA_Arrows.pdf", plot = soil_lda_results$arrow_plot, width = 8, height = 6)

# Evaluate Performance for Plant Parameters
plant_confusion <- table(Actual = Plant_param$Group, Predicted = plant_lda_results$predictions$class)
plant_accuracy <- sum(diag(plant_confusion)) / sum(plant_confusion)
cat("Plant LDA Accuracy:", plant_accuracy, "\n")

# Evaluate Performance for Soil Parameters
soil_confusion <- table(Actual = Soil_param$Group, Predicted = soil_lda_results$predictions$class)
soil_accuracy <- sum(diag(soil_confusion)) / sum(soil_confusion)
cat("Soil LDA Accuracy:", soil_accuracy, "\n")
