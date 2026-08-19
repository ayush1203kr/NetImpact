# Interview Preparation

## Project

**Tell me about NetImpact.** NetImpact is a MySQL and Power BI analysis of a telecom company's performance before and after a 5G launch. I created synthetic monthly data for 15 cities, 12 plans, and 24 months, then compared revenue, users, ARPU, cities, and plans.

**What business problem did you solve?** I gave leadership a simple view of whether revenue, customer activity, and the plan portfolio looked healthier after the launch.

**Why telecom?** Telecom naturally has monthly revenue, active users, unsubscribes, cities, and plans, so it is a clear setting for trend and period comparison analysis.

**Why MySQL and Power BI?** MySQL is useful for storing and querying structured data. Power BI makes results interactive through KPI cards, visuals, and slicers.

**What were your main findings?** Revenue increased 10.11%, active users fell 7.60%, unsubscribed users increased 57.77%, and ARPU rose from INR 876.27 to INR 1,044.26. I treated these as observations, not proof of causation.

**What recommendations did you make?** Investigate retention, review discontinued and declining plans, evaluate the new Ultra 5G plan, and use city-specific actions.

**What challenges did you face?** I had to keep synthetic data internally consistent, model it at a clear fact grain, and avoid overstating what a before/after comparison can prove.

## SQL

**JOIN vs LEFT JOIN?** JOIN returns matching rows from both tables. LEFT JOIN keeps every row from the left table, even without a match.

**WHERE vs HAVING?** WHERE filters rows before grouping. HAVING filters grouped results after aggregation.

**What is a CTE?** A CTE is a named temporary query result introduced with WITH. I used it to calculate monthly or city totals first, then calculate percentages or rankings clearly.

**What is a subquery?** A query inside another query. In this project, a subquery supplies total revenue so city revenue share can be calculated.

**What are window functions?** They calculate across related rows without collapsing them. I used LAG for month-over-month comparison and RANK to order plans within a period.

**Why RANK()?** It gives an understandable position to each plan while handling ties.

**How did you handle NULLs?** The quality script checks NULLs. In calculations I use NULLIF in denominators so division by zero does not create an error.

**How did you handle duplicates?** The fact table has a unique constraint at its declared grain, and the quality script checks duplicate counts.

**How did you calculate percentages?** Later value minus earlier value, divided by earlier value, multiplied by 100. NULLIF protects the denominator.

**How would you optimize a slow query?** Select only needed columns, filter early, check the execution plan, index join/filter keys, and avoid unnecessary repeated calculations.

## Power BI and DAX

**How did you connect MySQL to Power BI?** I installed the matching MySQL connector, chose Get Data → MySQL database, selected `netimpact`, and imported the four tables.

**What is a relationship?** It connects a dimension key to the matching fact key so a city or plan filter affects fact totals.

**What is a measure?** A DAX calculation evaluated when a visual is filtered. Total Revenue is a measure using SUM over revenue.

**Measure vs calculated column?** A measure is calculated dynamically in filter context. A calculated column is stored row by row. I use measures for KPIs because they respond to slicers.

**What is DAX?** Power BI's formula language for measures and calculations.

**Why measures?** Measures keep KPI logic in one place and recalculate for each city, plan, period, or month selected.

**What is CALCULATE?** CALCULATE evaluates an expression after changing filter context. The before/after revenue measures use it to select one period.

**What is filter context?** The filters created by slicers, visual axes, and page selections. It determines which fact rows a measure sees.

**Why these visuals?** Cards answer headline KPI questions, the line chart shows trend, bars compare cities and plans, and tables show exact changes.

**Why these slicers?** Period, city, plan, and plan type are the main dimensions for exploration.

**What is a star schema?** One central fact table connected to descriptive dimension tables. It is the model used here.
