-- =====================================================
-- Weather Data Warehouse
-- Database Creation Script
-- =====================================================

CREATE DATABASE IF NOT EXISTS weather_warehouse;

USE weather_warehouse;

-- =====================================================
-- Daily Weather Summary Table
-- =====================================================

CREATE TABLE IF NOT EXISTS daily_weather_summary (
weather_date DATE PRIMARY KEY,
avg_temperature DOUBLE NOT NULL,
max_temperature DOUBLE NOT NULL,
min_temperature DOUBLE NOT NULL,
avg_humidity DOUBLE NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Hourly Temperature Trend Table
-- =====================================================

CREATE TABLE IF NOT EXISTS hourly_temperature_trend (
weather_hour TINYINT PRIMARY KEY,
avg_temperature DOUBLE NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

```
CONSTRAINT chk_weather_hour
CHECK (weather_hour BETWEEN 0 AND 23)
```

);

-- =====================================================
-- Extreme Weather Report Table
-- =====================================================

CREATE TABLE IF NOT EXISTS extreme_weather_report (
weather_date DATE PRIMARY KEY,
avg_temperature DOUBLE NOT NULL,
max_temperature DOUBLE NOT NULL,
min_temperature DOUBLE NOT NULL,
avg_humidity DOUBLE NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Indexes
-- =====================================================

CREATE INDEX idx_daily_weather_date
ON daily_weather_summary(weather_date);

CREATE INDEX idx_extreme_weather_date
ON extreme_weather_report(weather_date);

-- =====================================================
-- Validation Queries
-- =====================================================

SHOW TABLES;

DESCRIBE daily_weather_summary;
DESCRIBE hourly_temperature_trend;
DESCRIBE extreme_weather_report;
