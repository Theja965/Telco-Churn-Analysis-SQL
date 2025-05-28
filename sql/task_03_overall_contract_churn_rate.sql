/*
Task 3: Overall Churn Rate by Contract Type

This query calculates the churn rate for customers based on their contract type.
It uses two CTEs to separate the counts of churned customers versus total customers for each contract.

Metric calculated:
- Churn Rate for each Contract Type ('Month-to-month', 'One year', 'Two year').
*/
with Churned_Customer_q AS (
select "Contract", "Churn", Count(*) as Churned_Customers
from "telco_data" td
where "Churn" = 'Yes'
group by "Contract", "Churn" ),

customer_total as (
select "Contract", count(*) as All_Customers
from "telco_data" td
group by "Contract"
)

select CCQ."Contract", CAST(Churned_Customers AS DECIMAL)/All_Customers as ChurnRate 
from Churned_Customer_q CCQ
join customer_total ct on CCQ."Contract" = ct."Contract"
ORDER BY CCQ."Contract"; 