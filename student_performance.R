#List of required packages
packages <- c("ggplot2", "dplyr", "scales", "tidyr","GGally","corrplot")

# Install any packages that are not already installed
installed_packages <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed_packages)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

# R Code for Data Understanding-------------------------------------------------PART A-------------------------------------------

# Load libraries
library(dplyr)

summary(student_data)


# Load dataset
student_data <- read.csv("student_data.csv", header = TRUE)

# First few rows
head(student_data)

# Dataset shape
cat("Rows: ", nrow(student_data), "\n")
cat("Columns: ", ncol(student_data), "\n")

# Data structure
str(student_data)

# Descriptive statistics
summary(student_data)

# Mode function
get_mode <- function(v) {
  uniq <- unique(v)
  uniq[which.max(tabulate(match(v, uniq)))]
}

sapply(student_data, get_mode)

# Identify categorical and numerical features
categorical_features <- names(student_data)[sapply(student_data, is.factor) | sapply(student_data, is.character)]
numeric_features <- names(student_data)[sapply(student_data, is.numeric)]

# R Code for EDA----------------------------------------------------------------PART B----------------------------------

library(ggplot2)
library(corrplot)

# Histograms
for (col in numeric_features) {
  print(
    ggplot(student_data, aes_string(col)) +
      geom_histogram(bins = 25) +
      ggtitle(paste("Histogram of", col))
  )
}

# Boxplots
for (col in numeric_features) {
  print(
    ggplot(student_data, aes_string(y = col)) +
      geom_boxplot() +
      ggtitle(paste("Boxplot of", col))
  )
}

# Bar charts for categorical variables
for (col in categorical_features) {
  print(
    ggplot(student_data, aes_string(col)) +
      geom_bar() +
      ggtitle(paste("Frequency of", col))
  )
}

# Correlation matrix
numeric_df <- student_data[, numeric_features]
cor_matrix <- cor(numeric_df, use = "complete.obs")
corrplot(cor_matrix, method = "color", type = "upper")

# Scatterplot matrix
pairs(numeric_df)

# Boxplots (categorical vs numeric)
for (cat in categorical_features) {
  for (num in numeric_features) {
    print(
      ggplot(student_data, aes_string(x = cat, y = num)) +
        geom_boxplot() +
        ggtitle(paste("Boxplot of", num, "by", cat))
    )
  }
}

#Data Preprocessing-------------------------------------------------------------PART C-------------------------------------------------

#1. Handling Missing Values

# Check missing values
colSums(is.na(student_data))

# Impute values
for (col in names(student_data)) {
  if (is.numeric(student_data[[col]])) {
    student_data[[col]][is.na(student_data[[col]])] <- mean(student_data[[col]], na.rm = TRUE)
  } else {
    student_data[[col]][is.na(student_data[[col]])] <- get_mode(student_data[[col]])
  }
}

#2. Handling Outliers (IQR Method)

num_cols <- names(student_data)[sapply(student_data, is.numeric)]

for (col in num_cols) {
  Q1 <- quantile(student_data[[col]], 0.25)
  Q3 <- quantile(student_data[[col]], 0.75)
  I <- Q3 - Q1
  
  lower <- Q1 - 1.5 * I
  upper <- Q3 + 1.5 * I
  
  student_data[[col]][student_data[[col]] < lower] <- lower
  student_data[[col]][student_data[[col]] > upper] <- upper
}

#3. Data Conversion (Encoding)

# Label Encoding
student_label <- student_data
for (col in categorical_features) {
  student_label[[col]] <- as.numeric(as.factor(student_label[[col]]))
}

# One-hot Encoding
library(caret)
dummies <- dummyVars("~ .", data = student_data)
student_onehot <- data.frame(predict(dummies, newdata = student_data))

#4. Data Transformation (Scaling & Log Transform)

# Standardization
student_scaled <- student_data
student_scaled[num_cols] <- scale(student_scaled[num_cols])

# Log transformation where possible
student_log <- student_data
for (col in num_cols) {
  if (all(student_log[[col]] > 0)) {
    student_log[[col]] <- log(student_log[[col]])
  }
}

#5. Feature Selection

# Correlation-based selection
cor_mat <- cor(student_onehot)
high_cor <- findCorrelation(cor_mat, cutoff = 0.85)
student_fs <- student_onehot[, -high_cor]

# Variance Thresholding
nzv <- nearZeroVar(student_onehot)
student_fs2 <- student_onehot[, -nzv]



