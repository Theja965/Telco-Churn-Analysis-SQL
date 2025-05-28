/*
Task 13: Analyzing Customers with "Premium" Phone Service

This query focuses on a specific segment of customers: those who have
`MultipleLines = 'Yes'` (considered a "premium" phone service setup).
The analysis aims to understand the churn behavior and financial contribution
of these customers across different stages of their tenure.

Analytical Goal:
- To gain insights into the lifecycle and risk factors for customers
  subscribing to multiple phone lines.

Key Steps & Metrics:
1.  **Initial Filtering:** Selects only customers with `MultipleLines = 'Yes'`.
2.  **Tenure Categorization:** Within this filtered group, assigns each customer
    to a `Tenure_Group` (decile) based on their tenure.
3.  **Group Aggregation:** Calculates for each `Tenure_Group`:
    - `Total_Customers_in_Group`
    - `Churned_Customers_in_Group`
    - `Churn_Rate_for_Group` (as a percentage).
    - `Average_MonthlyCharges_for_Group`

     */

with tenure_cte as(
select
"customerID",
"tenure",
"Churn",
"MonthlyCharges",
ntile(10) over (order by "tenure" DESc) as Tenure_Groups
from "telco_data" td
where "MultipleLines" = 'Yes'
)

select
Tenure_Groups,
COUNT("customerID") as Customer_total,
Count(case when "Churn" = 'Yes' then 1 end ) as Churn_count,
AVG("MonthlyCharges") as AVG_Monthly,
ROUND(CAST(Count(case when "Churn" = 'Yes' then 1 end )as DECIMAL)/COUNT("customerID")*100,2) as Churn_rate -- Added CAST for decimal division
from tenure_cte
group by Tenure_Groups
order by Tenure_Groups asc;