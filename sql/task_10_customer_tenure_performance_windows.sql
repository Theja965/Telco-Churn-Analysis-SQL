/*
Task 10: Analyzing Customer Tenure Performance with Window Functions

This query performs a detailed analysis of customer tenure by comparing individual customer
longevity against their specific peer groups (defined by Contract and PaymentMethod).
It utilizes various Window Functions to calculate relative performance metrics without
collapsing individual customer rows.

Key Metrics Calculated for each customer:
- Tenure_Rank_Within_Group: Rank of customer's tenure within their group.
- Tenure_Percentile_Within_Group: Percentile rank of tenure within their group.
- Average_Tenure_For_Group: The average tenure of all customers in their group.
- Tenure_Difference_From_Group_Avg: Difference between individual tenure and group average.
 */

with Window_CTE as(
select "customerID", "Contract", "PaymentMethod", "tenure",
NTILE(100) over(partition by "Contract", "PaymentMethod" order by "tenure") as Percentile,
AVG("tenure") over(partition by "Contract", "PaymentMethod") as AVG_TENURE,
dense_rank() over(partition by "Contract", "PaymentMethod" order BY "tenure" DESC) as Tenure_Ranked
from "telco_data" td
)

select WCTE."customerID", WCTE."Contract", WCTE."PaymentMethod", WCTE.Tenure_Ranked, WCTE.AVG_TENURE, WCTE.Percentile, ("tenure" - WCTE.AVG_TENURE) as Tenure_Difference
from Window_CTE WCTE
order by "Contract",
		 "PaymentMethod",
	     Tenure_Difference;