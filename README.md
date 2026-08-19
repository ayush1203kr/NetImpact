# NetImpact – Telecom Performance Analytics Platform

NetImpact is a **SQL and Power BI-based telecom analytics project** designed to evaluate business performance before and after a major network technology launch.

The project analyzes **revenue, customer activity, subscription behavior, city-level performance, and plan performance** to identify business trends and generate actionable recommendations.

---

## 📌 Project Overview

A leading telecom provider introduced 5G services to improve connectivity and customer experience. NetImpact compares **Before 5G vs After 5G** performance across key business metrics.

The analysis focuses on:

* Revenue performance
* Customer activity
* Customer unsubscribes
* ARPU
* City-level performance
* Telecom plan performance
* Plan lifecycle
* Business recommendations

---

## 🎯 Business Objectives

The project aims to answer key business questions:

* What changed in revenue after the 5G launch?
* How did active users change?
* Did unsubscribed users increase?
* How did ARPU change?
* Which cities performed strongly?
* Which telecom plans performed well?
* Which plans were significantly affected?
* Which plans were discontinued or newly introduced?
* Where should management investigate further?
* What actions could improve customer retention and revenue?

---

## 🛠️ Tech Stack

| Technology       | Purpose                                          |
| ---------------- | ------------------------------------------------ |
| **SQL / MySQL**  | Data modeling, validation, and business analysis |
| **Power BI**     | Interactive dashboards and visualization         |
| **DAX**          | KPI calculations and dashboard measures          |
| **Git & GitHub** | Version control and documentation                |

---

## 🔄 Analytics Workflow

```text
Synthetic Data
      ↓
MySQL Data Model
      ↓
Data Cleaning & Validation
      ↓
SQL Analysis
      ↓
KPI Calculation
      ↓
Power BI Data Model
      ↓
DAX Measures
      ↓
Interactive Dashboard
      ↓
Business Insights
      ↓
Recommendations
```

---

## 🗄️ Data Model

NetImpact follows a **star-schema design**.

```text
                         ┌──────────────────┐
                         │     dim_date     │
                         ├──────────────────┤
                         │ PK date_key      │
                         │ month_start      │
                         │ year             │
                         │ month_name       │
                         │ period           │
                         └────────┬─────────┘
                                  │
                                  │ 1 : Many
                                  ▼
┌──────────────────┐      ┌────────────────────────────┐
│    dim_city      │      │   fact_customer_activity  │
├──────────────────┤      ├────────────────────────────┤
│ PK city_key      │      │ PK activity_id             │
│ city_name        │      │ FK date_key                │
│ state_name       │      │ FK city_key                │
│ region           │      │ FK plan_key                │
└────────┬─────────┘      │ customer_group             │
         │                │ active_user                │
         │ 1 : Many       │ unsubscribed_user          │
         └───────────────►│ revenue                    │
                          └─────────────▲──────────────┘
                                        │
                                        │ 1 : Many
                               ┌────────┴─────────┐
                               │    dim_plan      │
                               ├──────────────────┤
                               │ PK plan_key      │
                               │ plan_name        │
                               │ plan_type        │
                               │ monthly_price    │
                               │ launch_period    │
                               │ plan_status      │
                               └──────────────────┘
```

### Relationships

```text
dim_date.date_key ──► fact_customer_activity.date_key
dim_city.city_key ──► fact_customer_activity.city_key
dim_plan.plan_key ──► fact_customer_activity.plan_key
```

Each dimension has a **1-to-many relationship** with the fact table.

---

## 📊 Key KPIs

| KPI                  | Description                         |
| -------------------- | ----------------------------------- |
| **Revenue**          | Total revenue generated             |
| **ARPU**             | Average Revenue Per Active User     |
| **TAU**              | Total Active Users                  |
| **TUsU**             | Total Unsubscribed Users            |
| **Revenue Change %** | Before vs After 5G revenue change   |
| **City Performance** | Revenue performance by city         |
| **Plan Performance** | Revenue performance by telecom plan |

---

## 🔍 Analysis & Insights

### 1. Revenue Impact

The analysis compares revenue before and after the 5G launch.

| Period     |     Revenue |
| ---------- | ----------: |
| Before 5G  |     $2.125B |
| After 5G   |     $2.339B |
| **Change** | **+10.11%** |

Revenue increased by approximately **10.11%** after the 5G launch.

> This is an observational Before-vs-After comparison and does not establish that 5G itself caused the change.

### 2. Customer KPI Performance

Customer activity showed a different trend from overall revenue.

| KPI  | Before 5G | After 5G |  Change |
| ---- | --------: | -------: | ------: |
| TAU  |    2.425M |   2.240M |  -7.60% |
| TUsU |     75.3K |   118.8K | +57.77% |

TAU decreased from **2.425M to 2.240M**, while unsubscribed users increased from **75.3K to 118.8K**.

This indicates a potential **customer-retention issue** requiring further investigation.

### 3. ARPU Performance

| Period     |        ARPU |
| ---------- | ----------: |
| Before 5G  |     $876.27 |
| After 5G   |   $1,044.26 |
| **Change** | **+19.17%** |

ARPU increased by approximately **19.17%**, indicating higher revenue generated per active user.

However, this should be evaluated alongside the decline in active users and increase in unsubscribed users.

### 4. City-Level Performance

The project evaluates revenue performance across **15 cities**.

The analysis compares:

* Revenue before 5G
* Revenue after 5G
* Revenue change %
* Revenue contribution
* Relative city performance

City-level analysis helps identify markets requiring additional investigation and supports targeted business actions.

### 5. Telecom Plan Performance

Plan-level revenue is compared across the pre- and post-5G periods.

The analysis identifies:

* High-performing plans
* Lower-performing plans
* Active plans
* Discontinued plans
* Newly introduced plans
* Plan-level revenue changes

The project also includes the **Ultra 5G 899** plan as a newly introduced plan.

### 6. Underperforming Plans

Two plans experienced substantial revenue declines after the 5G launch:

| Plan | Revenue Before | Revenue After | Change |
| ---- | -------------: | ------------: | -----: |
| P5   |        $1.000B |       $0.652B |   -35% |
| P7   |        $0.582B |       $0.156B |   -73% |

These plans should be investigated to determine whether the decline is associated with customer migration, plan changes, or other business factors.

### 7. Plan Lifecycle

The analysis also considers plan lifecycle status:

| Status           | Meaning                                   |
| ---------------- | ----------------------------------------- |
| **Active**       | Existing plan continuing in the portfolio |
| **Discontinued** | Plan with no After 5G activity            |
| **New**          | Plan introduced after the 5G launch       |

This helps distinguish between naturally underperforming plans and plans that were intentionally discontinued.

---

## 💡 Business Recommendations

### Customer Retention

Investigate the **57.77% increase in unsubscribed users** by city, plan, and month.

### Plan Optimization

Review lower-performing and discontinued plans to understand whether customers:

* Upgraded
* Downgraded
* Switched plans
* Churned

### 5G Plan Evaluation

Monitor the new **Ultra 5G 899** plan using:

* Revenue
* Active users
* ARPU
* Unsubscribed users

### City-Specific Strategy

Use city-level performance to identify markets requiring targeted retention, network, or promotional actions.

### Revenue + Retention Monitoring

Monitor revenue together with active users, unsubscribes, and ARPU to evaluate whether revenue growth is sustainable.

---

## 🧮 SQL Analysis

SQL is used for **data generation, validation, and business analysis**.

### Example: City Before vs After Revenue

```sql
SELECT
    c.city_name,
    SUM(
        CASE
            WHEN d.period = 'Before 5G'
            THEN f.revenue
            ELSE 0
        END
    ) AS before_5g_revenue,
    SUM(
        CASE
            WHEN d.period = 'After 5G'
            THEN f.revenue
            ELSE 0
        END
    ) AS after_5g_revenue
FROM fact_customer_activity f
JOIN dim_city c
    ON f.city_key = c.city_key
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY c.city_name;
```

The complete SQL implementation is available in:

```text
sql/
├── 01_create_database.sql
├── 02_data_quality_checks.sql
└── 03_analysis_queries.sql
```

Complete measures are documented in:

```text
powerbi/measures.md
```

---

## 📈 Power BI Dashboard

The Power BI dashboard provides an interactive one-page view of telecom performance.

### KPI Cards

* Total Revenue
* Revenue Change %
* Active Users
* Unsubscribed Users
* ARPU

### Main Visuals

* Monthly Revenue Trend
* Before vs After 5G Revenue
* Revenue by City
* Revenue by Plan
* Revenue by Plan Status

### Interactive Slicers

* Period
* City
* Plan
* Plan Type

The complete Power BI report is included at:

```text
powerbi/NetImpact.pbix
```

Detailed setup instructions are available in:

```text
powerbi/POWER_BI_SETUP.md
```

---

## 🧪 Data Quality & Validation

Expected fact records:

**17,280**

Validation queries are available in:

```text
sql/02_data_quality_checks.sql
```

---

## 📁 Project Structure

```text
NetImpact/
│
├── README.md
│
├── data/
│   └── data_dictionary.md
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_data_quality_checks.sql
│   └── 03_analysis_queries.sql
│
├── powerbi/
│   ├── NetImpact.pbix
│   ├── POWER_BI_SETUP.md
│   └── measures.md
│
├── dashboard/
│   └── README.md
│
├── docs/
│   ├── BUSINESS_INSIGHTS.md
│   ├── RECOMMENDATIONS.md
│   └── INTERVIEW_PREPARATION.md
│
└── memory/
    └── PRD.md
```

---

## 🚀 Setup

### 1. Create Database

```bash
mysql -u <user> -p < sql/01_create_database.sql
```

### 2. Run Data Quality Checks

```bash
mysql -u <user> -p netimpact < sql/02_data_quality_checks.sql
```

### 3. Run Analysis Queries

```bash
mysql -u <user> -p netimpact < sql/03_analysis_queries.sql
```

### 4. Open Power BI

Open:

```text
powerbi/NetImpact.pbix
```

Configure the MySQL connection if required and verify the relationships and measures.

---

## 📌 Key Takeaways

NetImpact demonstrates how SQL and Power BI can transform structured business data into actionable insights.

Key findings include:

* Revenue increased by **10.11%** after the 5G launch.
* Active users declined by **7.60%**.
* Unsubscribed users increased by **57.77%**.
* ARPU increased by approximately **19.17%**.
* City-level performance varied across markets.
* Certain telecom plans experienced substantial revenue declines.
* Plans were discontinued and new plans were introduced after the launch.
* Customer retention requires further investigation despite overall revenue growth.

### Core Business Insight

**Revenue growth alone does not necessarily indicate healthier customer performance.**

The combination of higher revenue and ARPU with declining active users and increasing unsubscribes makes **customer retention** an important area for further analysis.

---

## 👤 Author

**Ayush Kumar**

Integrated MSc Mathematics & Computing
Birla Institute of Technology, Mesra

**Analytics:** SQL | MySQL | Power BI | DAX | Excel
**Programming:** Python | Java | JavaScript

---

⭐ NetImpact demonstrates how structured business data can be transformed into actionable insights using SQL and Power BI.

