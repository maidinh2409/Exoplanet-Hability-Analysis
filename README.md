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

🔹 <ins>Stage 1: Data Ingestion & Storage</ins>

* Retrieved raw planetary data from two public sources: Asterank API (Kepler) and NASA Exoplanet Archive using Python scripts.
* Designed a structured schema and uploaded the raw data to Google Cloud Storage, preparing it for scalable analysis.

🔹 <ins>Stage 2: ELT Pipeline & Data Transformation</ins>

* Cleaned and standardized the data through feature engineering and quality checks.
* Loaded data into Google BigQuery and performed transformations using dbt, resulting in enriched and analysis-ready tables.

🔹 <ins>Stage 3: Modeling & Insight Delivery</ins>

* Built an ML pipeline using models like XGBoost and Random Forest to classify planets as potentially habitable -> Evaluated model performance and exported predictions.
* Simultaneously, created a Power BI dashboard to visualize trends and relationships from the transformed dataset.

![image](![image](https://github.com/user-attachments/assets/baaa8dec-bb6e-4ea3-948d-d825adbfa2e4))

### Data Schema Design - Snowflake Schema
![Data Schema Design (2)](https://github.com/user-attachments/assets/c6f68d8c-6d36-44a3-b3b6-b609d256544d)

