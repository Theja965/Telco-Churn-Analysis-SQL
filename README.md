# Diving Deep into Telco Churn with SQL: My Project
Hey there! This repository holds a project I've been working on to really dig into why customers leave telecom companies. It's built entirely using SQL, focusing on a dataset of telco customer behavior. My goal here was to sharpen my SQL skills and understand how data analytics can directly tackle a real business problem like customer churn.

### What's This All About?
Imagine a phone company wanting to stop customers from leaving. That's the core challenge this project addresses! I've used SQL to break down various aspects of customer data – from the kind of contracts they have, to their internet services, payment methods, and how long they've been with the company. The aim was to pinpoint patterns, identify high-risk groups, and generally figure out what drives churn.

### What I Did
I've crafted a series of SQL queries (you'll find them all in the `sql/` folder!) that cover a bunch of analytical ground:
* **Getting to know the data:** Checking out the table structure.
* **Churn Basics:** Simple counts and overall churn rates.
* **Deep Dives:** Analyzing churn based on different contract types, internet services (Fiber Optic vs. DSL!), and even specific add-on services like Device Protection.
* **Payment & Loyalty:** Exploring how payment methods relate to churn and checking out average customer tenure.
* **Spotting Risky Customers:** Using SQL techniques (like conditional aggregates and window functions) to profile customers who are likely to churn but might also be high-value.
* **Segmenting & Ranking:** Breaking down customers into groups by how long they've been with the company (tenure) and seeing which segments are most prone to churn.
* **Special Cases:** Looking at specific groups, like customers with multiple phone lines, to see their churn trends.
Each query aims to answer a specific question a business might have about its customers.

### Tools I Used
Just solid SQL and a few essentials:
* **SQL (PostgreSQL flavor):** All the heavy lifting happens here.
* **DBeaver:** My trusty SQL client for running queries.
* **Git & GitHub:** For version control and sharing this project with you!

### My Takeaways (The 'Aha!' Moments!)
Working through this project really highlighted some cool things:
* **Contract matters!** Month-to-month customers churn way more. That's a huge flag for retention efforts.
* **Fiber Optic paradox:** Sometimes, even "premium" services like Fiber Optic can come with high churn if customers aren't feeling supported (e.g., no online security or tech support).
* **Tenure tells a story:** New customers churn for different reasons than loyal, long-term ones. Understanding their journey is key.
* **The power of SQL:** You can uncover so much by just asking the right questions with SQL!

### Want to Check It Out?
Feel free to explore the `sql/` folder to see all the queries. If you have a PostgreSQL database and a similar Telco dataset, you can run these queries yourself!
