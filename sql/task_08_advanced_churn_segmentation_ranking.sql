/*
Task 8: Advanced Churn Segmentation - Top Churn Risk Segments by Tenure Cohort and Service Adoption

This query identifies and ranks the top 5 most churn-prone customer segments,
defined by a combination of their tenure cohort, internet service type, and
the absence of 'OnlineSecurity' and 'TechSupport' services.
It leverages multiple CTEs for layered aggregation and filtering, culminating in the use
of a ranking window function to pinpoint the highest-risk profiles.

Key Analytical Steps & Metrics:
1.  **Tenure Cohorting:** Customers are categorized into 'New' (0-12m), 'Mid-Term' (13-24m), and 'Long-Term' (>24m) cohorts.
2.  **Targeted Filtering:** Focuses exclusively on customers without 'OnlineSecurity' AND without 'TechSupport' (as these services often increase stickiness).
3.  **Segment Aggregation:** Calculates the total count of churned customers and the average monthly charges for each unique (InternetService, Tenure_Cohort) segment within the filtered group.
4.  **Ranking:** Assigns a rank to each segment based on its 'Churned_customers' count (highest churn = Rank 1).
5.  **Top N Selection:** Filters the results to display only the top 5 most churn-prone segments.
 */

with Churn_Segments as (
select "Churn", "InternetService", "OnlineSecurity", "TechSupport", "MonthlyCharges",
case
when "tenure" between 0 and 12 then 'New Customers'
when "tenure" between 13 and 24 then 'Mid-Term Customers'
when "tenure" > 24 then 'Long-Term Customers' -- Corrected consistent casing
end as Tenure_cohort
from "telco_data"
),

Aggregated_Segments AS(
select
"InternetService",
Tenure_cohort,
count(case when "Churn" = 'Yes' then 1 end) as Churned_customers,
ROUND(AVG("MonthlyCharges"),2) as AVG_Monthly
from Churn_Segments
where "OnlineSecurity" = 'No'
and "TechSupport" = 'No'
group by Tenure_cohort, "InternetService"
),

RANKED_CTE AS(
select
"InternetService",
Tenure_cohort,
Churned_customers,
AVG_Monthly,
rank() over(order by Churned_customers DESC ) as Ranked_Churn
from Aggregated_Segments
)

select *
from RANKED_CTE
where Ranked_Churn <= 5;