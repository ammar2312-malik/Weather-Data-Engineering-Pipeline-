-- =====================================================
-- Weather Analytics Queries
-- =====================================================

USE weather_warehouse;

-- =====================================================
-- 1. Daily Weather Summary
-- =====================================================

SELECT *
FROM daily_weather_summary
ORDER BY weather_date;

-- =====================================================
-- 2. Hottest Day
-- =====================================================

SELECT *
FROM daily_weather_summary
ORDER BY max_temperature DESC
LIMIT 1;

-- =====================================================
-- 3. Coldest Day
-- =====================================================

SELECT *
FROM daily_weather_summary
ORDER BY min_temperature ASC
LIMIT 1;

-- =====================================================
-- 4. Most Humid Day
-- =====================================================

SELECT *
FROM daily_weather_summary
ORDER BY avg_humidity DESC
LIMIT 1;

-- =====================================================
-- 5. Least Humid Day
-- =====================================================

SELECT *
FROM daily_weather_summary
ORDER BY avg_humidity ASC
LIMIT 1;

-- =====================================================
-- 6. Overall Average Temperature
-- =====================================================

SELECT
ROUND(AVG(avg_temperature),2) AS overall_avg_temperature
FROM daily_weather_summary;

-- =====================================================
-- 7. Overall Average Humidity
-- =====================================================

SELECT
ROUND(AVG(avg_humidity),2) AS overall_avg_humidity
FROM daily_weather_summary;

-- =====================================================
-- 8. Temperature Range Per Day
-- =====================================================

SELECT
weather_date,
max_temperature,
min_temperature,
ROUND(max_temperature - min_temperature,2)
AS temperature_range
FROM daily_weather_summary
ORDER BY temperature_range DESC;

-- =====================================================
-- 9. Top 5 Hottest Days
-- =====================================================

SELECT
weather_date,
max_temperature
FROM daily_weather_summary
ORDER BY max_temperature DESC
LIMIT 5;

-- =====================================================
-- 10. Top 5 Coldest Days
-- =====================================================

SELECT
weather_date,
min_temperature
FROM daily_weather_summary
ORDER BY min_temperature ASC
LIMIT 5;

-- =====================================================
-- 11. Hourly Temperature Trend
-- =====================================================

SELECT *
FROM hourly_temperature_trend
ORDER BY weather_hour;

-- =====================================================
-- 12. Hottest Hour Of The Day
-- =====================================================

SELECT *
FROM hourly_temperature_trend
ORDER BY avg_temperature DESC
LIMIT 1;

-- =====================================================
-- 13. Coolest Hour Of The Day
-- =====================================================

SELECT *
FROM hourly_temperature_trend
ORDER BY avg_temperature ASC
LIMIT 1;

-- =====================================================
-- 14. Day vs Night Temperature Comparison
-- =====================================================

SELECT
CASE
WHEN weather_hour BETWEEN 6 AND 18
THEN 'Day'
ELSE 'Night'
END AS period,
ROUND(AVG(avg_temperature),2)
AS avg_temperature
FROM hourly_temperature_trend
GROUP BY period;

-- =====================================================
-- 15. Days Above Average Temperature
-- =====================================================

SELECT *
FROM daily_weather_summary
WHERE avg_temperature >
(
SELECT AVG(avg_temperature)
FROM daily_weather_summary
)
ORDER BY avg_temperature DESC;

-- =====================================================
-- 16. Days Below Average Temperature
-- =====================================================

SELECT *
FROM daily_weather_summary
WHERE avg_temperature <
(
SELECT AVG(avg_temperature)
FROM daily_weather_summary
)
ORDER BY avg_temperature ASC;

-- =====================================================
-- 17. Extreme Weather Ranking
-- =====================================================

SELECT
weather_date,
max_temperature,
DENSE_RANK() OVER (
ORDER BY max_temperature DESC
) AS temperature_rank
FROM extreme_weather_report;

-- =====================================================
-- 18. Weather Warehouse Statistics
-- =====================================================

SELECT
COUNT(*) AS total_days,
ROUND(AVG(avg_temperature),2) AS avg_temp,
ROUND(MAX(max_temperature),2) AS highest_temp,
ROUND(MIN(min_temperature),2) AS lowest_temp,
ROUND(AVG(avg_humidity),2) AS avg_humidity
FROM daily_weather_summary;
