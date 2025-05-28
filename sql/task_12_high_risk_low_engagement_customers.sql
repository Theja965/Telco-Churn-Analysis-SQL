/*
Task 12: Identifying "High-Risk, Low-Engagement" Customers

This query aims to pinpoint a specific segment of customers who may be at
higher churn risk. It identifies customers whose monthly charges are below
the average for their specific contract type AND who lack key protective
services (Online Security, Tech Support) despite having Fiber Optic internet.

Analytical Goal:
- To find potentially vulnerable customers for targeted retention efforts.

Key Logic:
1.  Calculates the average MonthlyCharges for each Contract type using a
    window function (AVG() OVER (PARTITION BY "Contract")) on every customer row.
2.  Filters customers whose individual MonthlyCharges are less than their
    contract-specific average.
3.  Applies additional filters:
    - InternetService = 'Fiber optic'
    - OnlineSecurity = 'No'
    - TechSupport = 'No'
 */


with AVGM_CTE as(
select AVG("MonthlyCharges") over (partition by "Contract") as AVG_Monthly,
"Contract",
"customerID",
"MonthlyCharges",
"InternetService",
"OnlineSecurity",
"TechSupport"
from "telco_data" td
)

select ACGR."Contract",
ACGR."customerID",
ACGR."MonthlyCharges",
ACGR."InternetService",
ACGR."OnlineSecurity",
ACGR."TechSupport",
ACGR.AVG_Monthly
from AVGM_CTE ACGR
where ACGR."MonthlyCharges" < ACGR.AVG_Monthly
and ACGR."InternetService" = 'Fiber optic'
and ACGR."OnlineSecurity" = 'No'
and ACGR."TechSupport" = 'No'
order by "Contract",
"MonthlyCharges" ASC;