-- Task 2: Simple Customer Count by Contract and Churn Status
SELECT "Contract", "Churn", COUNT(*) AS customer_count
FROM telco_data
GROUP BY "Contract", "Churn"
ORDER BY "Contract", "Churn";