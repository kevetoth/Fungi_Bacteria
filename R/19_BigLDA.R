big_LDA <- perform_lda(plant_soil,  "Group", threshold = 0.1, plot_title_prefix = "All variables measured")

ggsave("Big_LDA_Plot.pdf", plot = plant_lda_results$lda_plot, width = 8, height = 6)
ggsave("Big_LDA_Arrows.pdf", plot = plant_lda_results$arrow_plot, width = 8, height = 6)