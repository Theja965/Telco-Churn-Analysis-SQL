/*
Task 5: Impact of Device Protection Service

This query calculates the churn rate for each category of the 'DeviceProtection' service.
It uses two CTEs to clearly separate the counts of churned customers versus total customers
for each device protection status.

Metric calculated:
- Churn Rate for each DeviceProtection status ('Yes', 'No', 'No internet service')
*/

with Churned_deviceprotection AS(
select "DeviceProtection", count(*) as churned_deviceprotection_num
from "telco_data"
where "Churn" = 'Yes'
group by "DeviceProtection"
),
All_Churn_device as (
select "DeviceProtection", count(*) as churned_alldeviceprotection
from "telco_data"
group by "DeviceProtection"
)

select cd."DeviceProtection",
cast(ROUND((CAST(CD.churned_deviceprotection_num as DECIMAL)/ ACD.churned_alldeviceprotection *100),2
)as TEXT) || '%' as Churned_deviceprotection_percent
from Churned_deviceprotection CD
join All_Churn_device ACD on CD."DeviceProtection" = ACD."DeviceProtection"
ORDER BY cd."DeviceProtection"; 