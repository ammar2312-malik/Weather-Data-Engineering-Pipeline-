# Weather Data Engineering Pipeline

## Project Overview

This project implements an end-to-end Weather Data Engineering Pipeline using Python, Apache Spark, PySpark, and MySQL.

The pipeline ingests historical weather data from the Open-Meteo API, processes it through a Medallion Architecture (Bronze, Silver, and Gold layers), and loads business-ready datasets into MySQL for analytics and reporting.

The primary goal of this project is to demonstrate core Data Engineering concepts including API ingestion, data transformation, data modeling, data warehousing, and analytical processing.

---

## Architecture

```text
Open-Meteo Weather API
           │
           ▼
    Bronze Layer
   (Raw JSON Data)
           │
           ▼
    Silver Layer
 (Cleaned Parquet Data)
           │
           ▼
     Gold Layer
(Business Aggregations)
           │
           ▼
   MySQL Warehouse
           │
           ▼
     SQL Analytics
```

---

## Tech Stack

* Python
* Apache Spark
* PySpark
* MySQL
* Jupyter Notebook
* Open-Meteo API
* Parquet File Format

---

## Project Objectives

* Ingest weather data from a REST API
* Store raw data in a Bronze Layer
* Transform and clean data using PySpark
* Build Silver and Gold layers following Medallion Architecture
* Generate business-ready analytical datasets
* Load processed data into MySQL
* Perform SQL-based analysis

---

## Data Flow

### Bronze Layer

Raw weather data is collected from the Open-Meteo API and stored in JSON format without modification.

Purpose:

* Preserve source data
* Enable reprocessing if required
* Maintain data lineage

Example Data:

```json
{
  "hourly": {
    "time": [...],
    "temperature_2m": [...],
    "relative_humidity_2m": [...]
  }
}
```

---

### Silver Layer

Raw API data is transformed into a structured tabular format using PySpark.

Transformations Performed:

* JSON parsing
* Schema inference
* Array flattening using arrays_zip()
* Row generation using explode()
* Timestamp conversion
* Data quality validation
* Metadata enrichment

Silver Schema:

| Column         | Data Type |
| -------------- | --------- |
| weather_time   | Timestamp |
| weather_date   | Date      |
| weather_hour   | Integer   |
| temperature    | Double    |
| humidity       | Integer   |
| ingestion_time | Timestamp |

Storage Format:

```text
Parquet
```

---

### Gold Layer

Business-ready aggregated datasets are created for analytics.

#### Daily Weather Summary

Metrics:

* Average Temperature
* Maximum Temperature
* Minimum Temperature
* Average Humidity

Columns:

```text
weather_date
avg_temperature
max_temperature
min_temperature
avg_humidity
```

---

#### Hourly Temperature Trend

Metrics:

* Average temperature by hour

Columns:

```text
weather_hour
avg_temperature
```

---

#### Extreme Weather Report

Identifies days with the highest and lowest temperatures.

Columns:

```text
weather_date
avg_temperature
max_temperature
min_temperature
avg_humidity
```

---

## MySQL Data Warehouse

The Gold datasets are loaded into MySQL for reporting and analysis.

Tables:

```sql
daily_weather_summary
hourly_temperature_trend
extreme_weather_report
```


## Project Structure

```text
weather-data-pipeline/

├── notebooks/
│   ├── 01_ingestion_Bronze.ipynb
│   ├── 02_Cleaning_Silver.ipynb
│   ├── 03_Gold_Data.ipynb
│   ├── 04_load_mysql.ipynb
│
├── data/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── sql/
│   ├── create_tables.sql
│   └── analytics_queries.sql
│
├── screenshots/
│
├── README.md
│
└── requirements.txt
```

---

## Key Data Engineering Concepts Demonstrated

* API Data Ingestion
* ETL / ELT Pipelines
* Medallion Architecture
* Data Cleaning
* Data Transformation
* PySpark DataFrames
* Nested JSON Processing
* Arrays and Struct Handling
* Parquet Storage
* Data Warehousing
* SQL Analytics
* Data Quality Validation

---

## Future Enhancements

* Automate pipeline execution using Apache Airflow
* Containerize project using Docker
* Implement incremental data loading
* Add weather dashboards using Power BI or Tableau
* Store data in a cloud data lake
* Integrate Apache Kafka for real-time weather streaming

---

## Author

Ammar Malik

Data Engineering Trainee

This project was built as part of a hands-on learning journey to strengthen Data Engineering fundamentals using Python, Apache Spark, PySpark, and MySQL.
