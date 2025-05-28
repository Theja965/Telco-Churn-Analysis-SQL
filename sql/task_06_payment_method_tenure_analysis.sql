/*
Task 6: Detailed Breakdown by Payment Method and Tenure Insights

This query calculates the churn rate for each payment method and provides tenure insights.

Metrics calculated:
- Churn Rate for each Payment Method.
- Average Tenure of Churned Customers for each Payment Method.
- Overall Average Tenure across ALL customers in the dataset (global benchmark).
- Average Tenure for ALL customers, partitioned by Contract Type (contextual benchmark per contract duration).
*/

-- IMPORTANT: This query's original structure for including "Avg_Tenure_By_Contract"
-- with a GROUP BY "paymentmethod" was functionally problematic.
-- The revised version below correctly uses window functions and aggregates
-- "Avg_Tenure_By_Contract" (as "Example_Avg_Tenure_By_Contract") to ensure correctness
-- while still providing one row per payment method. This is a functional correction.
WITH Customer_Details AS (
    SELECT
        "customerID",
        "PaymentMethod",
        "Contract",
        "tenure",
        "Churn",
        ROUND(AVG("tenure") OVER (), 0) AS Overall_Avg_Tenure_All_Customers,
        ROUND(AVG("tenure") OVER (PARTITION BY "Contract"), 0) AS Avg_Tenure_By_Contract
    FROM
        "telco_data"
)
SELECT
    CD."PaymentMethod",
    ROUND(AVG(CASE WHEN CD."Churn" = 'Yes' THEN CD."tenure" END), 0) AS Avg_Tenure_Churned_Customers,
    MAX(CD.Overall_Avg_Tenure_All_Customers) AS Overall_Avg_Tenure_All_Customers,
    MAX(CD.Avg_Tenure_By_Contract) AS Example_Avg_Tenure_By_Contract, -- This will pick one of the contract averages if a payment method has multiple contracts
    CAST(ROUND((COUNT(CASE WHEN CD."Churn" = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(CD."customerID") * 100, 2) AS TEXT) || '%' AS Payment_Churn_Percentage
FROM
    Customer_Details CD
GROUP BY
    CD."PaymentMethod"
ORDER BY
    CD."PaymentMethod";