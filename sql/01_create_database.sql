-- NetImpact: reproducible MySQL model and synthetic data
DROP DATABASE IF EXISTS netimpact;
CREATE DATABASE netimpact;
USE netimpact;

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    month_start DATE NOT NULL,
    year SMALLINT NOT NULL,
    month_name VARCHAR(12) NOT NULL,
    period VARCHAR(12) NOT NULL CHECK (period IN ('Before 5G', 'After 5G'))
);

CREATE TABLE dim_city (
    city_key INT PRIMARY KEY,
    city_name VARCHAR(40) NOT NULL UNIQUE,
    state_name VARCHAR(40) NOT NULL,
    region VARCHAR(10) NOT NULL
);

CREATE TABLE dim_plan (
    plan_key INT PRIMARY KEY,
    plan_name VARCHAR(50) NOT NULL UNIQUE,
    plan_type VARCHAR(10) NOT NULL CHECK (plan_type IN ('Prepaid', 'Postpaid')),
    monthly_price DECIMAL(10,2) NOT NULL CHECK (monthly_price > 0),
    launch_period VARCHAR(12) NOT NULL CHECK (launch_period IN ('Before 5G', 'After 5G')),
    plan_status VARCHAR(15) NOT NULL CHECK (plan_status IN ('Active', 'Discontinued', 'New'))
);

CREATE TABLE fact_customer_activity (
    activity_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    date_key INT NOT NULL,
    city_key INT NOT NULL,
    plan_key INT NOT NULL,
    customer_group VARCHAR(20) NOT NULL,
    active_user INT NOT NULL CHECK (active_user >= 0),
    unsubscribed_user INT NOT NULL CHECK (unsubscribed_user >= 0),
    revenue DECIMAL(14,2) NOT NULL CHECK (revenue >= 0),
    CONSTRAINT fk_fact_date FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    CONSTRAINT fk_fact_city FOREIGN KEY (city_key) REFERENCES dim_city(city_key),
    CONSTRAINT fk_fact_plan FOREIGN KEY (plan_key) REFERENCES dim_plan(plan_key),
    CONSTRAINT uq_activity_grain UNIQUE (date_key, city_key, plan_key, customer_group)
);

INSERT INTO dim_city VALUES
(1,'Mumbai','Maharashtra','West'),(2,'Delhi','Delhi','North'),(3,'Bengaluru','Karnataka','South'),
(4,'Hyderabad','Telangana','South'),(5,'Chennai','Tamil Nadu','South'),(6,'Kolkata','West Bengal','East'),
(7,'Pune','Maharashtra','West'),(8,'Ahmedabad','Gujarat','West'),(9,'Jaipur','Rajasthan','North'),
(10,'Lucknow','Uttar Pradesh','North'),(11,'Kochi','Kerala','South'),(12,'Chandigarh','Chandigarh','North'),
(13,'Indore','Madhya Pradesh','West'),(14,'Bhubaneswar','Odisha','East'),(15,'Guwahati','Assam','East');

INSERT INTO dim_plan VALUES
(1,'Connect 199','Prepaid',199,'Before 5G','Active'),(2,'Connect 299','Prepaid',299,'Before 5G','Active'),
(3,'Connect 399','Prepaid',399,'Before 5G','Active'),(4,'Max 499','Prepaid',499,'Before 5G','Active'),
(5,'Max 699','Prepaid',699,'Before 5G','Active'),(6,'Pro 799','Postpaid',799,'Before 5G','Active'),
(7,'Pro 999','Postpaid',999,'Before 5G','Active'),(8,'Family 1299','Postpaid',1299,'Before 5G','Active'),
(9,'Business 1599','Postpaid',1599,'Before 5G','Active'),(10,'Business 1999','Postpaid',1999,'Before 5G','Active'),
(11,'Legacy 249','Prepaid',249,'Before 5G','Discontinued'),(12,'Ultra 5G 899','Postpaid',899,'After 5G','New');

INSERT INTO dim_date
WITH RECURSIVE months AS (
    SELECT 0 AS n UNION ALL SELECT n + 1 FROM months WHERE n < 23
)
SELECT CAST(DATE_FORMAT(DATE_ADD('2024-01-01', INTERVAL n MONTH), '%Y%m') AS UNSIGNED),
       DATE_ADD('2024-01-01', INTERVAL n MONTH), YEAR(DATE_ADD('2024-01-01', INTERVAL n MONTH)),
       DATE_FORMAT(DATE_ADD('2024-01-01', INTERVAL n MONTH), '%M'),
       CASE WHEN n < 12 THEN 'Before 5G' ELSE 'After 5G' END
FROM months;

INSERT INTO fact_customer_activity
(date_key, city_key, plan_key, customer_group, active_user, unsubscribed_user, revenue)
WITH RECURSIVE months AS (
    SELECT 0 AS n UNION ALL SELECT n + 1 FROM months WHERE n < 23
), cohorts AS (
    SELECT 1 AS n UNION ALL SELECT n + 1 FROM cohorts WHERE n < 4
)
SELECT CAST(DATE_FORMAT(DATE_ADD('2024-01-01', INTERVAL m.n MONTH), '%Y%m') AS UNSIGNED),
       c.city_key, p.plan_key, CONCAT('Cohort ', g.n),
       CASE WHEN (m.n < 12 AND p.plan_key = 12) OR (m.n >= 12 AND p.plan_key = 11) THEN 0
            ELSE ROUND((110 + c.city_key * 7 + p.plan_key * 13 + g.n * 11)
                * (1 + MOD(c.city_key + p.plan_key + g.n, 5) / 20)
                * (CASE WHEN m.n < 12 THEN 1 ELSE 0.92 END)
                * (1 + MOD(m.n, 6) / 100)) END,
       CASE WHEN (m.n < 12 AND p.plan_key = 12) OR (m.n >= 12 AND p.plan_key = 11) THEN 0
            ELSE ROUND((110 + c.city_key * 7 + p.plan_key * 13 + g.n * 11) *
                (CASE WHEN m.n < 12 THEN 0.035 ELSE 0.055 END)) END,
       CASE WHEN (m.n < 12 AND p.plan_key = 12) OR (m.n >= 12 AND p.plan_key = 11) THEN 0
            ELSE ROUND((110 + c.city_key * 7 + p.plan_key * 13 + g.n * 11)
                * (1 + MOD(c.city_key + p.plan_key + g.n, 5) / 20)
                * (CASE WHEN m.n < 12 THEN 1 ELSE 0.92 END)
                * (1 + MOD(m.n, 6) / 100) * p.monthly_price
                * (CASE WHEN m.n < 12 THEN 1.00 ELSE 1.10 END), 2) END
FROM months m CROSS JOIN dim_city c CROSS JOIN dim_plan p CROSS JOIN cohorts g;

CREATE INDEX ix_fact_date ON fact_customer_activity(date_key);
CREATE INDEX ix_fact_city ON fact_customer_activity(city_key);
CREATE INDEX ix_fact_plan ON fact_customer_activity(plan_key);
