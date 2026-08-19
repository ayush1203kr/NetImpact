# NetImpact Data Dictionary

| Table | Column | Meaning |
|---|---|---|
| dim_date | date_key | Month key in YYYYMM format |
| dim_date | month_start | First day of the month |
| dim_date | year | Calendar year |
| dim_date | month_name | Month label |
| dim_date | period | Before 5G or After 5G |
| dim_city | city_key | City identifier |
| dim_city | city_name | Indian city |
| dim_city | state_name | State or union territory |
| dim_city | region | North, South, East, or West |
| dim_plan | plan_key | Plan identifier |
| dim_plan | plan_name | Customer-facing plan name |
| dim_plan | plan_type | Prepaid or Postpaid |
| dim_plan | monthly_price | Monthly plan price in INR |
| dim_plan | launch_period | Period when plan was introduced |
| dim_plan | plan_status | Active, Discontinued, or New |
| fact_customer_activity | activity_id | Fact row identifier |
| fact_customer_activity | date_key | Month foreign key |
| fact_customer_activity | city_key | City foreign key |
| fact_customer_activity | plan_key | Plan foreign key |
| fact_customer_activity | customer_group | Synthetic cohort label |
| fact_customer_activity | active_user | Active-user count for the cohort |
| fact_customer_activity | unsubscribed_user | Unsubscribed-user count for the cohort |
| fact_customer_activity | revenue | Monthly revenue in INR |

The fact grain is one customer cohort × city × plan × month. `active_user` and `unsubscribed_user` are additive counts. ARPU is revenue divided by active users.
