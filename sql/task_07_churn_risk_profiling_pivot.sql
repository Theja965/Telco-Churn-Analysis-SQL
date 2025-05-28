/*
Task 7: Churn Risk Profiling - High-Value, High-Risk Segments

This query profiles churn risk by combining contract type, internet service, and monthly charges.
It utilizes conditional aggregation to create a pivoted-like view, identifying customer segments
that are both high-risk for churn and potentially high-value in terms of monthly revenue.

Metrics calculated per Contract Type:
- Count of Churned Customers for Fiber Optic, DSL, and No Internet Service.
- Average Monthly Charges for ALL customers (not just churned) for Fiber Optic, DSL, and No Internet Service.
*/
SELECT
    "Contract",
    COUNT(CASE WHEN "InternetService" ='Fiber optic' AND "Churn" ='Yes' THEN 1 END) AS FiberOptic_Churn_Count,
    ROUND(AVG(CASE WHEN "InternetService" = 'Fiber optic' THEN "MonthlyCharges" END), 2) AS FiberOptic_AVGSpend,
    COUNT(CASE WHEN "InternetService" ='DSL' AND "Churn" ='Yes' THEN 1 END) AS DSL_Churn_Count,
    ROUND(AVG(CASE WHEN "InternetService" = 'DSL' THEN "MonthlyCharges" END), 2) AS DSL_AVGSpend,
    COUNT(CASE WHEN "InternetService" ='No' AND "Churn" ='Yes' THEN 1 END) AS NoInternet_Churn_Count,
    ROUND(AVG(CASE WHEN "InternetService" = 'No' THEN "MonthlyCharges" END), 2) AS NoInternet_AVGSpend
FROM
    "telco_data"
GROUP BY
    "Contract"
ORDER BY
    "Contract";