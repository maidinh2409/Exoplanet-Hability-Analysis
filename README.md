# Exoplanet-Habitability-Analysis

![image](https://github.com/user-attachments/assets/912935a7-0b9c-4bda-90e2-2f38da488d69)

## PROJECT OVERVIEW

What makes a planet potentially habitable? This question inspired the development of a full end-to-end data science pipeline focused on exoplanets beyond our solar system. 

I used open datasets from the NASA Exoplanet Archive API, HWC and hzgallery dataset. I cleaned and transformed the data to highlight key planetary features. With tools like dbt and BigQuery, I turned raw data into structured insights. Then, I built a Power BI dashboard so users can explore star systems and find planets with habitability potential. I also trained classification models to predict if a planet is potentially habitable. The models are easy to understand and ready for real-world use.

**<ins>Purpose:</ins>**
To investigate planetary habitability through the lens of data science—leveraging modern tools and best practices in data engineering, analytics, and machine learning to deliver both scientific insight and a scalable prediction system.

**<ins>Expected Outcomes:</ins>**

* BI Insights: Identify clusters of potentially habitable exoplanets based on star system properties, location, and physical traits
* ML Model: Predict the likelihood of exoplanet habitability with interpretable performance metrics and deployable logic

**<ins>Tech Stack:</ins>**

* Languages: Python, SQL
* Tools: dbt, Google BigQuery, Power BI, scikit-learn, XGBoost, APIs (NASA Exoplanet Archive)

## DATA OVERVIEW

This project uses three datasets to explore and model planetary habitability beyond our solar system.

### NASA Exoplanet Archive

The core dataset comes from the NASA Exoplanet Archive, a regularly updated source containing confirmed exoplanets and their key properties such as mass, radius, orbital period, and host star characteristics. This dataset serves as the foundation for extracting the most current and relevant planetary data (as of 2024).

### HWC (Habitable World Catalog)

The HWC dataset is curated by the Planetary Habitability Laboratory (PHL), also based on NASA data. It includes a list of potentially habitable exoplanets that have been manually reviewed and labeled as “Optimistic” or “Conservative”, based on how closely they align with Earth's known conditions. This dataset provides clear labels that support supervised machine learning and model evaluation.

### HZGallery

HZGallery provides detailed calculations of habitable zones for various star systems, helping identify whether a planet lies within the conservative or optimistic habitable zone. This is used to assign weightings to features such as stellar flux, distance to star, and equilibrium temperature — all of which contribute to scoring and labeling planetary habitability.

### Why combine HWC and HZGallery?

The HWC catalog provides expert-labeled planets as Conservative or Optimistic, making it ideal for training supervised models. However, it covers only a small subset of known exoplanets. The HZGallery dataset offers physics-based calculations of habitable zones for thousands of systems, allowing us to label additional planets based on their position relative to these zones.

By combining both, we:
* Use HWC as a reliable training set
* Extend labels to more planets using HZGallery
* Build a scalable and scientifically grounded habitability model

## PHASE 1: PLANNING
### Flowchart

🔹 <ins>Stage 1: Data Ingestion & Storage</ins>

* Retrieved raw planetary data from two public sources: NASA API using Python scripts.
* Designed a structured schema and uploaded the raw data to Google Cloud Storage, preparing it for scalable analysis.

🔹 <ins>Stage 2: ELT Pipeline & Data Transformation</ins>

* Cleaned and standardized the data through feature engineering and quality checks.
* Loaded data into Google BigQuery and performed transformations using dbt, resulting in enriched and analysis-ready tables.

🔹 <ins>Stage 3: Modeling & Insight Delivery</ins>

* Built an ML pipeline using models like XGBoost and Random Forest to classify planets as potentially habitable -> Evaluated model performance and exported predictions.
* Simultaneously, created a Power BI dashboard to visualize trends and relationships from the transformed dataset.

![image](https://github.com/user-attachments/assets/9fd14455-cac4-4315-bed5-381b74ad4f6b)

### Data Schema Design - Snowflake Schema

![image](https://github.com/user-attachments/assets/b58b1960-a929-4638-9be0-3ea890373c67)

### Dashboarding 

#### OVERVIEW
![image](https://github.com/user-attachments/assets/21dcb6a4-2e2b-4edf-a71c-f4a1de62044d)



