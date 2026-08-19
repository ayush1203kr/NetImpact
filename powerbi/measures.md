# Basic DAX Measures

Create these measures in `fact_customer_activity`:

```DAX
Total Revenue = SUM(fact_customer_activity[revenue])

Active Users = SUM(fact_customer_activity[active_user])

Unsubscribed Users = SUM(fact_customer_activity[unsubscribed_user])

ARPU = DIVIDE([Total Revenue], [Active Users])

Revenue Before 5G =
CALCULATE([Total Revenue], dim_date[period] = "Before 5G")

Revenue After 5G =
CALCULATE([Total Revenue], dim_date[period] = "After 5G")

Revenue Change % =
DIVIDE([Revenue After 5G] - [Revenue Before 5G], [Revenue Before 5G])

Active User Change % =
DIVIDE(
    CALCULATE([Active Users], dim_date[period] = "After 5G")
    - CALCULATE([Active Users], dim_date[period] = "Before 5G"),
    CALCULATE([Active Users], dim_date[period] = "Before 5G")
)
```

Format Total Revenue and ARPU as currency, Change measures as percentages, and user measures as whole numbers.
