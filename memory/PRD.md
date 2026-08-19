# NetImpact Project Record

## Architecture

MySQL → Power BI → Basic DAX → one dashboard → insights.

The project uses a star schema with three dimensions and one additive fact table. Synthetic data is deterministic and generated in MySQL.

## Implemented

- Four-table MySQL schema
- 15 Indian cities
- 12 plans
- 24 months
- Four cohorts per city-plan-month
- 17,280 fact rows
- Data-quality checks
- SQL analysis using joins, CTEs, subqueries, CASE, percentages, LAG, and RANK
- Basic DAX measures
- One-page Power BI specification
- Business insights, recommendations, and interview preparation

## Remaining

- Run SQL scripts on a local MySQL server.
- Build and save the genuine `NetImpact.pbix` locally in Power BI Desktop.
