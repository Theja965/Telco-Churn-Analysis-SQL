/*
Task 11: Identifying Churn Trends by Tenure Decile and Service Adoption Levels

This query analyzes customer churn behavior by categorizing customers into
specific segments based on their tenure (how long they've been with the company)
and their level of premium service adoption. The goal is to identify trends
and potential risk or retention areas.

Key Steps & Metrics:
1.  **Customer Categorization (per row):**
    - Assigns each customer to a `Tenure_Decile` (10 groups by tenure).
    - Calculates `Num_Premium_Services` (count of specific 'Yes' services per customer).
2.  **Aggregated Churn Analysis (per group):**
    - Groups customers by their `Tenure_Decile` and `Num_Premium_Services`.
    - Calculates `Total_Customers_in_Group`.
    - Calculates `Churned_Customers_in_Group`.
    - Calculates `Churn_Rate_for_Group` (as a percentage).
    */

with  NUM_DECILE_CTE as (
select "customerID", "tenure", "OnlineSecurity", "OnlineBackup", "DeviceProtection", "TechSupport", "StreamingTV", "StreamingMovies", "Churn",
NTILE(10) over(order by "tenure" desc) as Tenure_Groups,
case when "OnlineSecurity" = 'Yes' then 1 else 0 end +
case when  "OnlineBackup" = 'Yes' then 1 else 0 end +
case when  "DeviceProtection" = 'Yes' then 1 else 0 end +
case when  "TechSupport" = 'Yes' then 1 else 0 end +
case when  "StreamingTV" = 'Yes' then 1 else 0 end +
case when  "StreamingMovies" = 'Yes' then 1
else 0
end as Num_Premium_Services
from "telco_data"
)

select Tenure_Groups, Num_Premium_Services, COUNT("customerID") as total_customers,
COUNT(case when "Churn" = 'Yes' then 1 end) as churn_count,
ROUND(CAST(COUNT(case when "Churn" = 'Yes' then 1 end) as DECIMAL)/COUNT("customerID") * 100,2) as Churn_rate -- Added CAST for decimal division
from NUM_DECILE_CTE
group by Tenure_Groups, Num_Premium_Services
order by Churn_rate desc,
Tenure_Groups asc,
Num_Premium_Services asc;