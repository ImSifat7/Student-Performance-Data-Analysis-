Student Performance Data Analysis


📌 Overview
This project demonstrates a complete data science workflow applied to a real-world student performance dataset. The goal is to analyze how academic, demographic, and behavioral factors influence student outcomes. It includes:

Data loading and inspection
Exploratory Data Analysis (EDA)
Data preprocessing (handling missing values, outliers, encoding, scaling)
Feature selection for improved modeling


✅ Key Features

Data Understanding: Structure inspection, summary statistics, and feature identification.
EDA:

Histograms, boxplots, and bar charts for univariate analysis.
Correlation matrix and scatterplots for bivariate analysis.


Data Preprocessing:

Missing value imputation (mean for numeric, mode for categorical).
Outlier treatment using IQR method.
Encoding categorical variables (Label & One-hot encoding).
Scaling and log transformation for numerical features.


Feature Selection:

Correlation-based filtering.
Variance thresholding.




🛠 Technologies Used

Language: R
Libraries:

dplyr for data manipulation
ggplot2 for visualization
corrplot for correlation analysis
caret for encoding and feature selection




📂 Project Structure
├── data/
│   └── student_data.csv
├── scripts/
│   └── analysis.R
├── README.md
└── report/
    └── Student Performance Data Analysis.pdf


🚀 How to Run

Clone the repository:
Shellgit clone https://github.com/<your-username>/<repo-name>.gitShow more lines

Navigate to the project folder:
Shellcd <repo-name>Show more lines

Open analysis.R and run in RStudio or terminal:
Rsource("scripts/analysis.R")Show more lines



📊 Results

Cleaned and transformed dataset ready for predictive modeling.
Visual insights into student performance trends.
Reduced feature redundancy for better model efficiency.


📜 License
This project is licensed under the MIT License.
