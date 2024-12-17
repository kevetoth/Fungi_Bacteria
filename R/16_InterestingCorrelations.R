# First plot: Correlation between Root Length and Aboveground Biomass
subset_data <- plant_soil[, c("RootLength", "Aboveground_Biomass", "Group")]

# Fit a linear model to get the R-squared value
model <- lm(Aboveground_Biomass ~ RootLength, data = subset_data)
r_squared <- summary(model)$r.squared

# Scatter plot with color based on Group
library(ggplot2)
ggplot(subset_data, aes(x = RootLength, y = Aboveground_Biomass, color = Group)) +
  geom_point(alpha = 0.6, size = 2) + # Scatter plot
  geom_smooth(method = "lm", color = "red", se = FALSE) + # Linear regression line
  annotate("text", x = min(subset_data$RootLength, na.rm = TRUE), 
           y = max(subset_data$Aboveground_Biomass, na.rm = TRUE), 
           label = paste("R² =", round(r_squared, 3)),
           hjust = 0, vjust = 1, size = 5, color = "black") + # R-squared annotation
  labs(title = "Correlation between Root Length and Aboveground Biomass",
       x = "Root Length", y = "Aboveground Biomass") + 
  theme_minimal()


# Second plot: Correlation between SRL and Aboveground Biomass
subset_data <- plant_soil[, c("SRL", "Aboveground_Biomass", "Group")]

# Fit a linear model to get the R-squared value
model <- lm(Aboveground_Biomass ~ SRL, data = subset_data)
r_squared <- summary(model)$r.squared

# Scatter plot with color based on Group
ggplot(subset_data, aes(x = SRL, y = Aboveground_Biomass, color = Group)) +
  geom_point(alpha = 0.6, size = 2) + # Scatter plot
  geom_smooth(method = "lm", color = "red", se = FALSE) + # Linear regression line
  annotate("text", x = min(subset_data$SRL, na.rm = TRUE), 
           y = max(subset_data$Aboveground_Biomass, na.rm = TRUE), 
           label = paste("R² =", round(r_squared, 3)),
           hjust = 0, vjust = 1, size = 5, color = "black") + # R-squared annotation
  labs(title = "Correlation between SRL and Aboveground Biomass",
       x = "Specific Root Length (SRL)", y = "Aboveground Biomass") + 
  theme_minimal()


# Third plot: Correlation between Plant_P and SRL
subset_data <- plant_soil[, c("Plant_P", "SRL", "Group")]

# Fit a linear model to get the R-squared value
model <- lm(SRL ~ Plant_P, data = subset_data)
r_squared <- summary(model)$r.squared

# Scatter plot with color based on Group
ggplot(subset_data, aes(x = Plant_P, y = SRL, color = Group)) +
  geom_point(alpha = 0.6, size = 2) + # Scatter plot
  geom_smooth(method = "lm", color = "red", se = FALSE) + # Linear regression line
  annotate("text", x = min(subset_data$Plant_P, na.rm = TRUE), 
           y = max(subset_data$SRL, na.rm = TRUE), 
           label = paste("R² =", round(r_squared, 3)),
           hjust = 0, vjust = 1, size = 5, color = "black") + # R-squared annotation
  labs(title = "Correlation between Plant_P and SRL",
       x = "Plant P", y = "SRL") + 
  theme_minimal()


# Fourth plot: Correlation between Plant_P and Root Length
subset_data <- plant_soil[, c("Plant_P", "RootLength", "Group")]

# Fit a linear model to get the R-squared value
model <- lm(Plant_P ~ RootLength, data = subset_data)
r_squared <- summary(model)$r.squared

# Scatter plot with color based on Group
ggplot(subset_data, aes(x = RootLength, y = Plant_P, color = Group)) +
  geom_point(alpha = 0.6, size = 2) + # Scatter plot
  geom_smooth(method = "lm", color = "red", se = FALSE) + # Linear regression line
  annotate("text", x = min(subset_data$RootLength, na.rm = TRUE), 
           y = max(subset_data$Plant_P, na.rm = TRUE), 
           label = paste("R² =", round(r_squared, 3)),
           hjust = 0, vjust = 1, size = 5, color = "black") + # R-squared annotation
  labs(title = "Correlation between Plant_P and Root Length",
       x = "Root Length", y = "Plant P") + 
  theme_minimal()





# Subset the relevant columns
subset_data <- plant_soil[, c("Total_Biomass", "Plant_P", "Group")]

# Fit a linear model to get the R-squared value
model <- lm(Plant_P ~ Total_Biomass, data = subset_data)
r_squared <- summary(model)$r.squared

# Create the scatter plot with a linear model, color by Group, and annotate the R-squared value
library(ggplot2)
ggplot(subset_data, aes(x = Total_Biomass, y = Plant_P, color = Group)) +
  geom_point(alpha = 0.6, size = 2) + # Scatter plot with color by Group
  geom_smooth(method = "lm", color = "red", se = FALSE) + # Linear regression line
  annotate("text", x = min(subset_data$Total_Biomass, na.rm = TRUE), 
           y = max(subset_data$Plant_P, na.rm = TRUE), 
           label = paste("R² =", round(r_squared, 3)),
           hjust = 0, vjust = 1, size = 5, color = "black") + # R-squared annotation
  labs(title = "Correlation between Total Biomass and Plant P",
       x = "Total Biomass", y = "Plant P") + # Axis labels
  theme_minimal()



# Subset the relevant columns and filter for Group A2 and AB5
subset_data <- plant_soil[plant_soil$Group %in% c("A2", "AB5"), c("Total_Biomass", "Plant_P", "Group")]

# Fit a linear model to get the R-squared value
model <- lm(Plant_P ~ Total_Biomass, data = subset_data)
r_squared <- summary(model)$r.squared

# Create the scatter plot with a linear model, color by Group, and annotate the R-squared value
library(ggplot2)
ggplot(subset_data, aes(x = Total_Biomass, y = Plant_P, color = Group)) +
  geom_point(alpha = 0.6, size = 2) + # Scatter plot with color by Group
  geom_smooth(method = "lm", color = "red", se = FALSE) + # Linear regression line
  annotate("text", x = min(subset_data$Total_Biomass, na.rm = TRUE), 
           y = max(subset_data$Plant_P, na.rm = TRUE), 
           label = paste("R² =", round(r_squared, 3)),
           hjust = 0, vjust = 1, size = 5, color = "black") + # R-squared annotation
  labs(title = "Correlation between Total Biomass and Plant P (A2 & AB5)",
       x = "Total Biomass", y = "Plant P") + # Axis labels
  theme_minimal()





# Subset the relevant columns
subset_data <- plant_soil[, c("Rootbranches", "Aboveground_Biomass", "Group")]

# Fit a linear model to get the R-squared value
model <- lm(Aboveground_Biomass ~ Rootbranches, data = subset_data)
r_squared <- summary(model)$r.squared

# Create the scatter plot with a linear model, color by Group, and annotate the R-squared value
library(ggplot2)
ggplot(subset_data, aes(x = Rootbranches, y = Aboveground_Biomass, color = Group)) +
  geom_point(alpha = 0.6, size = 2) + # Scatter plot with color by Group
  geom_smooth(method = "lm", color = "red", se = FALSE) + # Linear regression line
  annotate("text", x = min(subset_data$Rootbranches, na.rm = TRUE), 
           y = max(subset_data$Aboveground_Biomass, na.rm = TRUE), 
           label = paste("R² =", round(r_squared, 3)),
           hjust = 0, vjust = 1, size = 5, color = "black") + # R-squared annotation
  labs(title = "Correlation between Root Branches and Aboveground Biomass",
       x = "Root Branches", y = "Aboveground Biomass") + # Axis labels
  theme_minimal()


# Subset the relevant columns
subset_data <- plant_soil[, c("Rootbranches", "Plant_P", "Group")]

# Fit a linear model to get the R-squared value
model <- lm(Plant_P ~ Rootbranches, data = subset_data)
r_squared <- summary(model)$r.squared

# Create the scatter plot with a linear model, color by Group, and annotate the R-squared value
library(ggplot2)
ggplot(subset_data, aes(x = Rootbranches, y = Plant_P, color = Group)) +
  geom_point(alpha = 0.6, size = 2) + # Scatter plot with color by Group
  geom_smooth(method = "lm", color = "red", se = FALSE) + # Linear regression line
  annotate("text", x = min(subset_data$Rootbranches, na.rm = TRUE), 
           y = max(subset_data$Plant_P, na.rm = TRUE), 
           label = paste("R² =", round(r_squared, 3)),
           hjust = 0, vjust = 1, size = 5, color = "black") + # R-squared annotation
  labs(title = "Correlation between Root Branches and Plant P",
       x = "Root Branches", y = "Plant P") + # Axis labels
  theme_minimal()

