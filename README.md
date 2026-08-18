# Strava End-to-End Data Analytics

An end-to-end data analytics project based on Strava fitness data, covering data cleaning, SQL analysis, Tableau dashboarding, and Python Exploratory Data Analysis (EDA).

## Project Overview

This project analyzes fitness and activity data to identify patterns in user activity, calorie expenditure, sleep behavior, and overall engagement.

The project follows a complete analytics workflow:

**Data → SQL Cleaning → Business Insights → Tableau Dashboard → Python EDA → Recommendations**

## Tools & Technologies

- **SQL** – Data cleaning, transformation, and business analysis
- **Tableau** – Interactive dashboard and data visualization
- **Python** – Exploratory Data Analysis
- **Pandas** – Data manipulation
- **Matplotlib** – Data visualization
- **Seaborn** – Statistical visualization
- **Jupyter Notebook** – Python EDA environment

## Project Workflow

### 1. Data Cleaning using SQL

The original Strava dataset consisted of multiple related datasets.

SQL was used to:

- Clean and transform the data
- Handle missing and inconsistent values
- Join relevant datasets
- Prepare an analysis-ready dataset
- Create business-focused metrics

The final cleaned dataset extracted from SQL is included in this repository.

### 2. SQL Business Analysis

SQL queries were developed to answer important business questions related to:

- User activity levels
- Daily steps
- Calories burned
- Active and sedentary time
- Sleep duration
- Sleep efficiency
- Relationships between activity and sleep behavior

The SQL analysis generated actionable insights that can help understand user behavior and engagement.

### 3. Tableau Dashboard

The cleaned data was used to create an interactive Tableau dashboard.

The dashboard focuses on:

- Activity performance
- Steps and calories
- Activity intensity
- Sleep patterns
- User behavior
- Key performance indicators

The dashboard provides a visual overview of the major patterns identified during the analysis.

### 4. Python Exploratory Data Analysis

Python was used to perform detailed EDA on the cleaned dataset.

The analysis includes:

- Dataset understanding
- Variable exploration
- Data type validation
- Unique value analysis
- Data wrangling
- Distribution and relationship analysis
- Data visualization
- Correlation analysis
- Pair plot analysis

Multiple visualizations were created to understand relationships between activity, calories, steps, sleep, and other fitness variables.

## Key Areas Analyzed

- Daily step trends
- Average steps by activity level
- Steps vs calories
- Sleep duration vs total steps
- Calories by activity level
- Active minutes by activity level
- Sleep efficiency
- Sedentary behavior
- Sleep duration
- Time spent in bed
- Day-type activity patterns
- Correlations between numerical variables

## Repository Structure

```text
Strava-End-to-End-Data-Analytics/
│
├── README.md
│
├── Dataset/
│   └── Cleaned_Dataset.csv
│
├── SQL/
│   ├── Data_Cleaning.sql
│   └── Business_Insights.sql
│
├── Tableau/
│   ├── Strava_Dashboard.twbx
│   └── Dashboard_Screenshots/
│
├── Python_EDA/
│   └── Strava_EDA.ipynb
│
└── Insights/
    ├── SQL_Insights.pdf
    └── Tableau_Insights.pdf
