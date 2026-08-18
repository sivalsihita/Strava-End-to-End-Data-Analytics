# Strava End-to-End Data Analytics

An end-to-end data analytics project based on Strava fitness data, covering data cleaning, SQL analysis, Tableau dashboarding, and Python Exploratory Data Analysis (EDA).

---

## 📌 Project Overview

This project analyzes Strava fitness and activity data to identify patterns in user activity, calorie expenditure, sleep behavior, sedentary time, and overall fitness trends.

The project follows a complete data analytics workflow, starting with data cleaning and transformation in SQL, followed by business-oriented analysis, interactive visualization in Tableau, and detailed exploratory data analysis using Python.

---

## 🎯 Project Objectives

- Clean and prepare the fitness dataset for analysis.
- Perform SQL-based data transformation and validation.
- Generate meaningful business insights using SQL queries.
- Develop an interactive Tableau dashboard to visualize key metrics.
- Perform Exploratory Data Analysis (EDA) using Python.
- Identify relationships and patterns between activity, sleep, calorie expenditure, and other fitness metrics.
- Present the findings in a clear and business-oriented manner.

---

## 🔄 Project Workflow

```text
Strava Fitness Data
        ↓
SQL Data Cleaning
        ↓
Cleaned Dataset
        ↓
SQL Business Analysis
        ↓
Business Insights
        ↓
Tableau Dashboard
        ↓
Python Exploratory Data Analysis
        ↓
Final Findings & Recommendations
```

---

## 🗂️ Dataset

The project uses Strava fitness and activity data containing variables related to:

- Physical activity
- Steps
- Calories
- Active minutes
- Sedentary minutes
- Sleep duration
- Sleep efficiency
- Time spent in bed
- Activity levels
- Sleep segments
- Day type

The repository contains the **cleaned dataset generated during the SQL cleaning process**.

---

## 🧹 SQL Data Cleaning

SQL was used to prepare the dataset for downstream analysis.

The cleaning process included:

- Data validation
- Handling missing and inconsistent values
- Data transformation
- Creation and modification of analytical fields
- Categorization of activity and sleep-related variables
- Preparation of a final cleaned dataset for analysis

**File:** `SQL/Data_Cleaning.sql`

---

## 📊 SQL Business Analysis

Business-oriented SQL queries were developed to identify meaningful patterns and relationships within the dataset.

The analysis focused on areas such as:

- Activity levels
- Steps and physical activity
- Calorie expenditure
- Sleep behavior
- Sedentary activity
- Relationships between fitness-related variables

**File:** `SQL/Business_Insights.sql`

A detailed report of the SQL findings is available in the `Insights` folder.

---

## 📈 Tableau Dashboard

An interactive Tableau dashboard was developed to present the major findings from the cleaned dataset.

The dashboard provides a visual overview of:

- Activity patterns
- Step counts
- Calorie expenditure
- Sleep metrics
- Active and sedentary minutes
- Differences across activity levels
- Key fitness indicators

**Dashboard file:** `Tableau/Strava_Dashboard.twbx`

---

## 🐍 Python Exploratory Data Analysis

Python was used to perform detailed Exploratory Data Analysis after the SQL cleaning and business analysis stages.

The EDA included:

- Univariate analysis
- Comparative analysis
- Activity-level analysis
- Sleep analysis
- Correlation analysis
- Pair plot analysis
- Visualization of relationships between fitness metrics

The analysis examined relationships involving variables such as:

- Total steps
- Calories
- Active minutes
- Sedentary minutes
- Sleep duration
- Sleep efficiency
- Time in bed

**Notebook:** `Python/PythonStrava_EDA.ipynb`

---

## 💡 Key Analytical Areas

The project explores questions such as:

- How do activity levels differ across users?
- How are physical activity and calorie expenditure related?
- How does sleep duration vary across activity levels?
- How does sleep efficiency vary across different sleep segments?
- How do active and sedentary minutes differ by activity level?
- Are there meaningful relationships between steps, calories, activity, and sleep metrics?
- How do weekday and weekend activity levels compare?

---

## 📁 Repository Structure

```text
Strava-End-to-End-Data-Analytics/
│
├── Dataset/
│   └── Cleaned_Dataset.csv
│
├── Insights/
│   ├── SQL_Insights.pdf
│   └── Tableau_Insights.pdf
│
├── Python/
│   └── PythonStrava_EDA.ipynb
│
├── SQL/
│   ├── Data_Cleaning.sql
│   └── Business_Insights.sql
│
├── Tableau/
│   └── Strava_Dashboard.twbx
│
└── README.md
```

---

## 🛠️ Tools & Technologies

- **SQL** – Data cleaning, transformation and business analysis
- **Tableau** – Interactive dashboard development and visualization
- **Python** – Exploratory Data Analysis
- **Pandas** – Data manipulation
- **Matplotlib** – Data visualization
- **Seaborn** – Statistical visualization
- **Jupyter Notebook** – Python EDA environment

---

## 📄 Project Reports

Detailed analytical findings are available in:

- **SQL Insights:** `Insights/SQL_Insights.pdf`
- **Tableau Insights:** `Insights/Tableau_Insights.pdf`

---

## ✅ Conclusion

This project demonstrates an end-to-end data analytics workflow, combining SQL, Tableau, and Python to transform fitness data into meaningful insights.

The analysis provides a structured view of activity, sleep, calorie expenditure, and sedentary behavior while demonstrating the complete process from data preparation to visualization and exploratory analysis.

---

## 👩‍💻 Author

**Ishita Sival**

B.Tech Graduate | Aspiring Data Analyst
