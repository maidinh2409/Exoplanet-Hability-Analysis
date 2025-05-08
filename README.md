# Exoplanet-Habitability-Analysis

![image](https://github.com/user-attachments/assets/912935a7-0b9c-4bda-90e2-2f38da488d69)

## PROJECT OVERVIEW

What makes a planet potentially habitable? This question inspired the development of a full end-to-end data science pipeline focused on exoplanets beyond our solar system. From scraping raw astronomical data to deploying a machine learning model, this project simulates a real-world data science workflow—bridging scientific curiosity with technical execution.

Starting with publicly available datasets from the NASA Exoplanet Archive and Asterank API, I built a robust data pipeline to clean, transform, and model planetary features. Using tools like dbt and BigQuery, the raw data was turned into structured insights, enabling deeper analysis of planetary systems.

A Power BI dashboard brought those insights to life, allowing users to explore star systems and identify planets with habitability potential. Finally, I trained classification models that predict whether a planet is potentially habitable, with results that are both interpretable and ready for deployment.

**<ins>Purpose:</ins>**
To investigate planetary habitability through the lens of data science—leveraging modern tools and best practices in data engineering, analytics, and machine learning to deliver both scientific insight and a scalable prediction system.

**<ins>Expected Outcomes:</ins>**

* BI Insights: Identify clusters of potentially habitable exoplanets based on star system properties, location, and physical traits
* ML Model: Predict the likelihood of exoplanet habitability with interpretable performance metrics and deployable logic

**<ins>Tech Stack:</ins>**

* Languages: Python, SQL
* Tools: dbt, Google BigQuery, Power BI, scikit-learn, XGBoost, APIs (NASA, Asterank)

## PHASE 1: PLANNING
### Flowchart

**1. Data Extraction:**
I began by querying astronomical data from the NASA Exoplanet Archive and Asterank API, integrating multiple sources into a centralized data lake. This phase emphasized handling API data, structuring inconsistent fields, and preparing the data for analytical use.

**2. ELT (Extract, Load, Transform)**

* Using Google BigQuery as the data warehouse and dbt for transformation logic, I implemented a modular ELT pipeline. Here, I applied:
* Standardization of planetary metrics (e.g. mass, radius, orbital period)
* Feature engineering to derive habitability-relevant features
* Data validation tests to ensure pipeline integrity

**3. Product Deployment & Insights**
For the final stage, I delivered two outputs:

<ins>Business Intelligence Dashboard (Power BI):</ins> Visualized planetary patterns, economic potential, and the proportion of planets falling into high-habitability zones. Enabled filtering by star type, distance from Earth, and potential value.

<ins>Machine Learning Model (Python):</ins> Built a logistic regression and XGBoost model to classify planets as “Potentially Habitable” or “Non-Habitable” using astrophysical features. Evaluated on precision, recall, and F1-score.

![image](https://github.com/user-attachments/assets/2a44f309-00b3-44c4-b617-9bc92ad19f81)

### Data Schema Design - Snowflake Schema
![Data Schema Design (2)](https://github.com/user-attachments/assets/c6f68d8c-6d36-44a3-b3b6-b609d256544d)

