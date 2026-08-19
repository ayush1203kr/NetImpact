# NetImpact – Telecom Performance Analytics Platform

NetImpact is a simple, interview-focused analytics project for evaluating a telecom company's performance before and after a 5G launch. It uses only **MySQL**, **Power BI**, basic **DAX**, and Git/GitHub.

## Business problem

Leadership wants to compare revenue, users, ARPU, cities, and plans across two periods. The analysis describes observed changes; it does not claim that 5G caused them.

## Dataset and schema

The project creates realistic synthetic monthly activity for 15 Indian cities, 12 plans, 24 months, and four customer cohorts per city-plan-month. The resulting fact table contains **17,280 records**.

```text
dim_date ─────┐
dim_city ─────┼── fact_customer_activity
dim_plan ────┘
```

See `data/data_dictionary.md` for field definitions.

## SQL analysis

Run the scripts in order:

1. `sql/01_create_database.sql`
2. `sql/02_data_quality_checks.sql`
3. `sql/03_analysis_queries.sql`

The generated story is intentionally modest: revenue changes after 5G, active users decline, and unsubscribed users increase. These are observations requiring further investigation.

## Power BI dashboard

Build one page with KPI cards for Total Revenue, Revenue Change %, Active Users, Unsubscribed Users, and ARPU. Add monthly revenue, before/after revenue, city revenue and change %, plan performance, and top/bottom plan visuals. Use Period, City, Plan, and Plan Type slicers. Full instructions are in `powerbi/POWER_BI_SETUP.md`.

## Basic DAX

The measures in `powerbi/measures.md` demonstrate `SUM`, `DIVIDE`, `CALCULATE`, and filter context without advanced DAX.

## Setup

```bash
mysql -u <user> -p < sql/01_create_database.sql
mysql -u <user> -p netimpact < sql/02_data_quality_checks.sql
mysql -u <user> -p netimpact < sql/03_analysis_queries.sql
```

Then follow the Power BI Desktop steps in `powerbi/POWER_BI_SETUP.md`.

## Skills demonstrated

MySQL data modeling, data quality checks, aggregations, joins, CTEs, subqueries, window functions, percentage calculations, star-schema thinking, Power BI visual design, and basic DAX.
