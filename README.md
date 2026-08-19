# NetImpact – A Telecom Performance Analytics Platform

NetImpact is a **SQL and Power BI-based telecom analytics project** designed to evaluate business performance before and after a major network technology launch.

The project analyzes **revenue, customer activity, subscription behavior, city-level performance, and plan performance** to identify business trends and generate actionable recommendations.

---

## 📌 Project Overview

A leading telecom provider introduced 5G services to improve connectivity and customer experience. However, post-launch performance showed changes in revenue and customer activity.

NetImpact analyzes the business impact of the 5G launch by comparing **Before 5G vs After 5G** performance across key business metrics.

The analysis focuses on:

* Revenue performance
* Customer activity
* Customer unsubscribes
* City-level performance
* Telecom plan performance
* Underperforming plans
* Discontinued plans
* Business recommendations

---

## 🎯 Business Objectives

The project aims to answer key business questions:

* What was the impact of the 5G launch on revenue?
* Which KPIs underperformed after the launch?
* Which telecom plans performed well?
* Which plans were significantly affected?
* Which plans were discontinued after the launch?
* Which cities experienced positive or negative performance?
* What actions can improve customer retention and revenue?

---

## 🛠️ Tech Stack

* **SQL / MySQL** – Data querying and business analysis
* **Power BI** – Interactive dashboards and visualization
* **DAX** – KPI calculations and dashboard measures
* **Git & GitHub** – Version control and documentation

---

## 🔄 Analytics Workflow

```text
Raw Data
   ↓
Data Cleaning & Validation
   ↓
SQL Analysis
   ↓
KPI Calculation
   ↓
Power BI Data Model
   ↓
Interactive Dashboard
   ↓
Business Insights
   ↓
Recommendations
```

---

## 📊 Key KPIs

NetImpact focuses on the following performance indicators:

| KPI              | Description                         |
| ---------------- | ----------------------------------- |
| Revenue          | Total revenue generated             |
| ARPU             | Average Revenue Per User            |
| TAU              | Total Active Users                  |
| TUsU             | Total Unsubscribed Users            |
| Revenue Change % | Before vs After 5G revenue change   |
| City Performance | Revenue performance by city         |
| Plan Performance | Revenue performance by telecom plan |

---

## 🔍 Analysis & Insights

### 1. Revenue Impact

The analysis compares revenue before and after the 5G launch.

| Period    |   Revenue |
| --------- | --------: |
| Before 5G |    ₹16.0B |
| After 5G  |    ₹15.9B |
| Change    | **-0.5%** |

The analysis indicates a **0.5% decline in revenue** after the 5G launch.

---

### 2. Customer KPI Performance

Customer activity showed a more significant change than overall revenue.

| KPI  | Before 5G | After 5G |
| ---- | --------: | -------: |
| TAU  |     84.4M |    77.4M |
| TUsU |      5.6M |     7.0M |

TAU decreased from **84.4M to 77.4M**, while unsubscribed users increased from **5.6M to 7.0M**.

This indicates a potential customer-retention issue requiring further investigation.

---

### 3. City-Level Performance

The project evaluates revenue performance across 15 cities.

Key observations include:

* Mumbai generated the highest revenue.
* Raipur generated the lowest revenue.
* Several cities experienced positive revenue changes.
* Delhi, Chennai and Ahmedabad experienced negative changes.

The city-level analysis helps identify markets requiring additional investigation and targeted business actions.

---

### 4. Telecom Plan Performance

Plan-level revenue was compared across the pre- and post-5G periods.

The analysis identified:

* **P1, P2 and P3** as strong-performing plans.
* **P9 and P10** as lower-performing plans before the launch.
* **P8, P9 and P10** as discontinued plans after the launch.
* **P11, P12 and P13** as newly introduced plans.

---

### 5. Underperforming Plans

Two plans were identified as being significantly affected after the 5G launch:

| Plan | Revenue Before | Revenue After |   Change |
| ---- | -------------: | ------------: | -------: |
| P5   |          ₹1.0B |       ₹651.5M | **-35%** |
| P7   |        ₹582.4M |       ₹155.6M | **-73%** |

The analysis recommends evaluating whether these plans should be retained, modified or discontinued based on their post-launch performance.

---

## 💡 Business Recommendations

Based on the analysis, the project proposes:

### Family & Business Plans

Introduce separate offerings for individual and business customers with shared-data options.

### Prepaid & Postpaid Options

Provide customers with greater flexibility through both prepaid and postpaid plans.

### Network Expansion

Expand 5G coverage and invest in network infrastructure.

### Promotional Offers

Use incentives and seasonal promotions to encourage customers to adopt 5G.

### Customer Support

Improve support during the 5G transition through additional customer-service resources and digital assistance.

---

## 🧮 SQL Analysis

SQL is used to transform business requirements into analytical queries and KPIs.

Key SQL concepts include:

* SELECT
* WHERE
* GROUP BY
* ORDER BY
* Aggregate Functions
* CASE WHEN
* JOINs
* Subqueries
* CTEs
* Window Functions
* Ranking
* Percentage Calculations
* Before-vs-After Analysis

Example:

```sql
SELECT
    city,
    SUM(CASE
        WHEN period = 'Before 5G' THEN revenue
        ELSE 0
    END) AS before_5g_revenue,

    SUM(CASE
        WHEN period = 'After 5G' THEN revenue
        ELSE 0
    END) AS after_5g_revenue
FROM telecom_data
GROUP BY city;
```

---

## 📈 Power BI Dashboard

The Power BI dashboard provides an interactive view of:

* Revenue
* ARPU
* TAU
* TUsU
* Before vs After 5G comparison
* Monthly revenue trends
* City performance
* Plan performance
* Revenue change %
* KPI performance

### Dashboard Preview

Add your Power BI dashboard screenshot here:

```text
dashboard/
└── netimpact_dashboard.png
```

---

## 📁 Project Structure

```text
NetImpact/
│
├── README.md
│
├── data/
│   ├── dim_date.csv
│   ├── dim_city.csv
│   ├── dim_plan.csv
│   └── fact_metrics.csv
│
├── sql/
│   └── analysis_queries.sql
│
├── powerbi/
│   └── NetImpact.pbix
│
├── dashboard/
│   └── netimpact_dashboard.png
│
└── presentation/
    └── business_insights.pdf
```

---

## 📌 Key Takeaways

NetImpact demonstrates how **SQL and Power BI can transform raw business data into actionable insights**.

Key findings include:

* Revenue decreased slightly after the 5G launch.
* Active users declined significantly.
* Unsubscribed users increased.
* City-level performance varied across markets.
* Certain telecom plans experienced substantial revenue declines.
* Several plans were discontinued while new plans were introduced.
* Customer retention and network adoption require targeted business strategies.

---

## 🚀 Skills Demonstrated

* SQL Analytics
* MySQL
* Power BI
* DAX
* Data Cleaning
* Data Transformation
* KPI Development
* Customer Analytics
* Revenue Analysis
* Trend Analysis
* Segmentation
* Business Intelligence
* Data Visualization
* Root-Cause Analysis
* Business Storytelling
* Data-Driven Decision Making

---

## 🎓 Project Context

NetImpact is based on a telecom business case study focused on evaluating the impact of a 5G service launch.

The project is intended for **learning, portfolio development, and demonstrating practical SQL and Power BI analytics skills**.

---

## 👤 Author

**Ayush Kumar**

Integrated MSc Mathematics & Computing
Birla Institute of Technology, Mesra

**Analytics:** SQL | MySQL | Power BI | Excel
**Programming:** Python | Java | JavaScript

---

⭐ If you found this project useful, consider giving the repository a star.
