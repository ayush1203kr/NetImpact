USE netimpact;

-- Q1. Overall KPI comparison.
SELECT d.period, ROUND(SUM(f.revenue),2) AS total_revenue,
       SUM(f.active_user) AS active_users, SUM(f.unsubscribed_user) AS unsubscribed_users,
       ROUND(SUM(f.revenue) / NULLIF(SUM(f.active_user),0),2) AS arpu
FROM fact_customer_activity f JOIN dim_date d ON f.date_key=d.date_key
GROUP BY d.period ORDER BY CASE d.period WHEN 'Before 5G' THEN 1 ELSE 2 END;

-- Q2. Before/after revenue percentage.
SELECT ROUND((SUM(CASE WHEN d.period='After 5G' THEN f.revenue ELSE 0 END) -
              SUM(CASE WHEN d.period='Before 5G' THEN f.revenue ELSE 0 END)) /
             NULLIF(SUM(CASE WHEN d.period='Before 5G' THEN f.revenue ELSE 0 END),0) * 100, 2)
       AS revenue_change_pct
FROM fact_customer_activity f JOIN dim_date d ON f.date_key=d.date_key;

-- Q3. Monthly trend with month-over-month change.
WITH monthly AS (
    SELECT d.month_start, d.period, SUM(f.revenue) AS monthly_revenue
    FROM fact_customer_activity f JOIN dim_date d ON f.date_key=d.date_key
    GROUP BY d.month_start, d.period
)
SELECT month_start, period, ROUND(monthly_revenue,2) AS monthly_revenue,
       ROUND((monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month_start)) /
             NULLIF(LAG(monthly_revenue) OVER (ORDER BY month_start),0) * 100,2) AS mom_change_pct
FROM monthly ORDER BY month_start;

-- Q4. City performance.
WITH city_period AS (
    SELECT c.city_name,
           SUM(CASE WHEN d.period='Before 5G' THEN f.revenue ELSE 0 END) AS before_revenue,
           SUM(CASE WHEN d.period='After 5G' THEN f.revenue ELSE 0 END) AS after_revenue
    FROM fact_customer_activity f JOIN dim_city c ON f.city_key=c.city_key JOIN dim_date d ON f.date_key=d.date_key
    GROUP BY c.city_name
)
SELECT city_name, ROUND(before_revenue,2) AS before_revenue, ROUND(after_revenue,2) AS after_revenue,
       ROUND((after_revenue-before_revenue)/NULLIF(before_revenue,0)*100,2) AS revenue_change_pct
FROM city_period ORDER BY after_revenue DESC;

-- Q5. Plan performance.
SELECT p.plan_name, p.plan_type, p.plan_status,
       ROUND(SUM(f.revenue),2) AS total_revenue, SUM(f.active_user) AS active_users,
       ROUND(SUM(f.revenue)/NULLIF(SUM(f.active_user),0),2) AS arpu
FROM dim_plan p LEFT JOIN fact_customer_activity f ON p.plan_key=f.plan_key
GROUP BY p.plan_key, p.plan_name, p.plan_type, p.plan_status
ORDER BY total_revenue DESC;

-- Q6. Rank plans within each period.
WITH plan_period AS (
    SELECT d.period, p.plan_name, SUM(f.revenue) AS revenue
    FROM fact_customer_activity f JOIN dim_plan p ON f.plan_key=p.plan_key JOIN dim_date d ON f.date_key=d.date_key
    GROUP BY d.period, p.plan_name
)
SELECT period, plan_name, ROUND(revenue,2) AS revenue,
       RANK() OVER (PARTITION BY period ORDER BY revenue DESC) AS revenue_rank
FROM plan_period ORDER BY period, revenue_rank;

-- Q7. Top/bottom plans by After 5G revenue; zero-activity lifecycle plans remain visible.
WITH ranked AS (
    SELECT p.plan_name, p.plan_status,
           SUM(CASE WHEN d.period='After 5G' THEN f.revenue ELSE 0 END) AS revenue,
           RANK() OVER (ORDER BY SUM(CASE WHEN d.period='After 5G' THEN f.revenue ELSE 0 END) DESC) AS top_rank,
           RANK() OVER (ORDER BY SUM(CASE WHEN d.period='After 5G' THEN f.revenue ELSE 0 END)) AS bottom_rank
    FROM dim_plan p LEFT JOIN fact_customer_activity f ON p.plan_key=f.plan_key
         LEFT JOIN dim_date d ON f.date_key=d.date_key AND d.period='After 5G'
    GROUP BY p.plan_key, p.plan_name, p.plan_status
)
SELECT plan_name, plan_status, ROUND(revenue,2) AS after_5g_revenue,
       CASE WHEN top_rank <= 3 THEN 'Top 3' WHEN bottom_rank <= 3 THEN 'Bottom 3' END AS performance_group
FROM ranked WHERE top_rank <= 3 OR bottom_rank <= 3 ORDER BY after_5g_revenue DESC;

-- Q8. Plan lifecycle.
SELECT plan_name, plan_type, launch_period, plan_status,
       CASE WHEN plan_status='New' THEN 'Introduced after 5G'
            WHEN plan_status='Discontinued' THEN 'No activity after 5G'
            ELSE 'Continued' END AS lifecycle_summary
FROM dim_plan ORDER BY plan_key;

-- Q9. City revenue share.
WITH city_revenue AS (
    SELECT c.city_name, SUM(f.revenue) AS revenue
    FROM fact_customer_activity f JOIN dim_city c ON f.city_key=c.city_key
    GROUP BY c.city_name
)
SELECT city_name, ROUND(revenue,2) AS revenue,
       ROUND(revenue / (SELECT SUM(revenue) FROM city_revenue) * 100,2) AS revenue_share_pct
FROM city_revenue ORDER BY revenue DESC;
