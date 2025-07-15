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

## PHASE 2: DATA EXTRACTION & LOADING TO GOOGLE BIG QUERY

In this phase, I used Python to extract data from the NASA Exoplanet Archive API, selecting only the necessary features based on a predefined data schema. The extracted data was saved as JSON files to Google Cloud Storage (GCS). I also uploaded the HZGallery and HWC datasets (in CSV format) to GCS. Next, I defined table schemas and created structured tables in Google BigQuery for each dataset, preparing them for transformation.

## PHASE 3: DATA TRANSFORMATION & RE-LOADING WITH DBT

In this phase, I used dbt (data build tool) to transform the raw datasets into clean, structured models ready for analysis and machine learning. The transformation followed the standard ELT (Extract–Load–Transform) pipeline using BigQuery as the data warehouse.

Data transformations were structured into dbt model layers, each with a clear purpose:

### 1. Raw Models

* Ingested raw data as-is
* Standardized formatting (e.g., date, boolean, number)
* Created composite keys: planet_id, star_id, facility_id, detection_id using concatenation of relevant columns

### 2. Staging Models

* Cleaned noisy data: Removed nulls, duplicates, and outliers. Handled inconsistent values and type mismatches
* Renamed and standardized column names for consistency

### 3. Intermediate Models

Performed feature engineering, such as:

* Calculated Earth Similarity Index (ESI) for NASA planets
* Categorized planets in HZGallery as Optimistic or Conservative based on the percentage of orbital overlap with habitable zones

### 4. Fact Models

* Joined the NASA, HZGallery, and HWC datasets using shared IDs
* Created final habitability labels
* Computed a composite habitability score using weighted logic:
  - HWC label weight = 2 (due to expert-reviewed nature)
  - HZGallery label weight = 1 (based on physical model calculations)
### 5. BI Queries

* Built curated queries and views to support Power BI dashboards
* Pre-aggregated key metrics for performance

### 6. YAML + Tests

* Defined dbt schema.yml files
* Wrote unit tests for complex logic such as: ID generation, CASE WHEN conditions, Multi-column concatenation
* Ensured data integrity across models with dbt’s built-in testing framework

## PHASE 4: PRODUCT DEPLOYMENT

### BUSINESS INTELLIGENCE WITH POWER BI

####  📊 OVERVIEW DASHBOARD
![image](https://github.com/user-attachments/assets/21dcb6a4-2e2b-4edf-a71c-f4a1de62044d)

🔍 Field & Term Explanations

| Field/Label                   | Explanation |
|------------------------------|-------------|
| **E. Temp (°C)**             | Estimated surface temperature of the planet assuming no atmospheric effects. |
| **Density**                  | Average density of the planet in g/cm³, used to infer its composition (e.g., rocky, gaseous). |
| **Period**                   | Orbital period: how long the planet takes to complete one orbit around its host star (in Earth days). |
| **ESI (Earth Similarity Index)** | Score from 0 to 100 indicating how similar a planet is to Earth in terms of physical conditions. |
| **Spectral Type (M, K, G)**  | Stellar classification based on temperature and light:  **M**: red dwarfs, small and cool, most common, **K**: orange stars, warmer than M-type, **G**: yellow stars like the Sun |
| **Optimistic / Conservative** | Labels from the HWC dataset representing habitability likelihood:  **Optimistic**: broader zone, more relaxed criteria (water worlds or mini-Neptunes, with a lower likelihood of habitable conditions),**Conservative**: stricter criteria, closer match to Earth conditions (rocky planets capable of surface liquid water)  |
| **Most Potential World**     | Planet with the highest composite habitability score and Earth Similarity Index (ESI). |
| **Closest Habitable World**  | Nearest conservative planet to Earth. |
| **Top Facilities**           | Major observatories or missions that discovered the planets (e.g., Kepler, K2, MEarth). |

####  📊 FEATURE ANALYSIS DASHBOARD

![image](https://github.com/user-attachments/assets/34af6846-250a-4dd0-809b-3fff81f22704)

🔍 Field & Term Explanations

| Term                     | Description                                                                                 | Unit / Scale            |
|--------------------------|---------------------------------------------------------------------------------------------|--------------------------|
| **Planet Orbit**         | Semi-major axis – the average distance between a planet and its host star                  |
| **Star Luminosity**      | Total energy output of the star per second                                                  |
| **Star Temperature**     | Surface temperature of the star                                                               |
| **Planet Flux**          | Amount of stellar energy received per unit area on the planet                              |
| **Planet Density**       | Average mass per unit volume of the planet                                                 |

#### KEY INSIGHTS:

* According to major research, M-type stars (red dwarfs) are the most common in the universe. However, analysis of NASA's exoplanet database shows G-type stars (like the Sun) dominate the dataset—likely because missions like Kepler focus on finding Earth-like planets around Sun-like stars.
* M-type stars account for the highest share of optimistic planets (56% of all optimistic + conservative planets orbit M-type stars). However, their conservative-to-optimistic ratio is lower than K-type stars, likely because their close-in habitable zones cause many planets to become tidally locked—with one side permanently facing the star, creating extreme climates that limit strict habitability.
* Most optimistic and conservative planets cluster around 200–300 K, supporting the possibility of liquid water.
* Pessimistic planets dominate edge conditions: extreme stellar flux, very low/high luminosity, and unstable orbits.
* In contrast, optimistic and conservative planets concentrate in a moderate, balanced zone in terms of star luminosity, stellar flux, orbital distance, and planetary density.
* Finally, star characteristics, especially luminosity and temperature, play a critical role in whether planets fall within habitable zones.
