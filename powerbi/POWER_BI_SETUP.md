# Power BI Desktop Setup

## Connect to MySQL

1. Install the MySQL Connector/NET matching Power BI Desktop's bitness.
2. Run `sql/01_create_database.sql`, then the checking and analysis scripts.
3. Open Power BI Desktop and choose **Get data → MySQL database**.
4. Enter the server name, database `netimpact`, and choose **Import**.
5. Select `dim_date`, `dim_city`, `dim_plan`, and `fact_customer_activity`.
6. Confirm one-to-many relationships from each dimension key to its matching fact key, with single-direction filtering.
7. Add the measures from `measures.md` to the fact table.

## One-page dashboard design

Title: **NetImpact | Before vs After 5G**

Slicers:
- `dim_date[period]`
- `dim_city[city_name]`
- `dim_plan[plan_name]`
- `dim_plan[plan_type]`

KPI cards:
- Total Revenue
- Revenue Change %
- Active Users
- Unsubscribed Users
- ARPU

Visuals:
- Monthly revenue line chart
- Before vs After 5G revenue clustered column chart
- City revenue bar chart
- City comparison table with Revenue Change %
- Plan revenue bar chart
- Plan table showing status and ARPU

Keep one page. Add the note: “Period comparisons show observations, not proven causation.”

## Final checks

Clear each slicer and confirm visuals respond. Compare cards with SQL totals from `03_analysis_queries.sql`. Save the report locally as `NetImpact.pbix`.
