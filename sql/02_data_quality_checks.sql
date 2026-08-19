USE netimpact;

SELECT 'fact_row_count' AS check_name, COUNT(*) AS result FROM fact_customer_activity;
SELECT 'null_fact_values' AS check_name, COUNT(*) AS result
FROM fact_customer_activity
WHERE date_key IS NULL OR city_key IS NULL OR plan_key IS NULL OR customer_group IS NULL
   OR active_user IS NULL OR unsubscribed_user IS NULL OR revenue IS NULL;

SELECT 'duplicate_city_names' AS check_name, COUNT(*) - COUNT(DISTINCT city_name) AS result FROM dim_city;
SELECT 'duplicate_plan_names' AS check_name, COUNT(*) - COUNT(DISTINCT plan_name) AS result FROM dim_plan;
SELECT 'duplicate_fact_grain' AS check_name,
       COUNT(*) - COUNT(DISTINCT CONCAT(date_key,'-',city_key,'-',plan_key,'-',customer_group)) AS result
FROM fact_customer_activity;

SELECT 'negative_values' AS check_name, COUNT(*) AS result FROM fact_customer_activity
WHERE active_user < 0 OR unsubscribed_user < 0 OR revenue < 0;

SELECT 'orphan_date_keys' AS check_name, COUNT(*) AS result
FROM fact_customer_activity f LEFT JOIN dim_date d ON f.date_key = d.date_key
WHERE d.date_key IS NULL;

SELECT 'orphan_city_keys' AS check_name, COUNT(*) AS result
FROM fact_customer_activity f LEFT JOIN dim_city c ON f.city_key = c.city_key
WHERE c.city_key IS NULL;

SELECT 'orphan_plan_keys' AS check_name, COUNT(*) AS result
FROM fact_customer_activity f LEFT JOIN dim_plan p ON f.plan_key = p.plan_key
WHERE p.plan_key IS NULL;

SELECT 'legacy_after_5g_activity' AS check_name, COUNT(*) AS result
FROM fact_customer_activity f JOIN dim_date d ON f.date_key=d.date_key
WHERE d.period='After 5G' AND f.plan_key=11 AND (f.active_user<>0 OR f.revenue<>0);

SELECT 'new_plan_before_5g_activity' AS check_name, COUNT(*) AS result
FROM fact_customer_activity f JOIN dim_date d ON f.date_key=d.date_key
WHERE d.period='Before 5G' AND f.plan_key=12 AND (f.active_user<>0 OR f.revenue<>0);
