/*
Task 9: Churn Patterns by Contract Type and Payment Method

This query investigates customer churn behavior by examining the interplay between different
contract types and payment methods. It aims to identify specific combinations that show
higher churn rates, providing insights into contractual terms and payment preferences
that may impact customer retention.

Key Metrics Calculated:
- Total Customers per (Contract, PaymentMethod) combination
- Number of Churned Customers per combination
- Churn Rate (Percentage of Churned Customers) per combination
Results are ordered by the highest churn rate.
 */


with Contact_CHURN_COUNT AS(
select "Contract", "PaymentMethod", Count("customerID") as Customers, COUNT(case when "Churn" = 'Yes' then 1 END) as Churned_Count
from "telco_data"
group by "Contract", "PaymentMethod"
)

select CCC."Contract", CCC."PaymentMethod",CCC.Customers, ROUND((cast( CCC.Churned_Count as DECIMAL)/CCC.Customers)*100 ,2) as Churn_percent -- Added CAST for decimal division
from Contact_CHURN_COUNT CCC
order by Churn_percent DESC;