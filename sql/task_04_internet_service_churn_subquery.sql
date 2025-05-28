/*
Task 4: Churn Rate by Contract Type and Internet Service

This query calculates the churn rate for customers based on their contract type
and the type of internet service they subscribe to. It explicitly includes
the count of churned customers for each combination.

Metric calculated:
- Churn Rate for each combination of Contract Type and Internet Service.
- Count of Churned Customers for each combination.
*/

with Churned_Customer_CONRACT_INTERNET AS(
select "Contract", "InternetService", count(*) as churn_customers
from "telco_data"
where "Churn" = 'Yes'
group by "Contract", "InternetService")

SELECT
td."Contract",
td."InternetService",
td.churn_customers,
ROUND(
CAST(churn_customers as DECIMAL)/
from "telco_data" dt
where dt."Contract" = td."Contract"
and dt."InternetService" = td."InternetService"
)
* 100,2)as ChurnRate_CONTRACT_INTERNET
from Churned_Customer_CONRACT_INTERNET td
ORDER BY td."Contract", td."InternetService"; 