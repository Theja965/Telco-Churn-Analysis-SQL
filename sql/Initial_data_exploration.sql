-- Task 1: Initial Data Exploration: Viewing table schema
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'telco_data'
ORDER BY column_name;