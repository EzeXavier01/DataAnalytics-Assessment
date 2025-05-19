# Task:  Write a query to find customers with at least one funded savings plan AND one funded investment plan,
# sorted by total deposits

# Extract the full name of the user
WITH users AS (
    SELECT CONCAT(first_name, ' ', last_name) AS name, id AS owner_id
    FROM adashi_staging.users_customuser
),

# Getting users with investment plan
investment AS (
    SELECT sa.owner_id, COUNT(DISTINCT (sa.plan_id)) AS investment_count, SUM(sa.confirmed_amount) AS total_investment
    FROM savings_savingsaccount sa
    JOIN plans_plan p
	ON sa.plan_id = p.id
    WHERE sa.transaction_status = 'success' AND p.is_fixed_investment = 1
    GROUP BY sa.owner_id
),

# Getting users with savings plan
savings AS (
    SELECT sa.owner_id, SUM(sa.confirmed_amount) AS total_savings, COUNT(DISTINCT (sa.plan_id)) AS savings_count
    FROM savings_savingsaccount AS sa
    JOIN plans_plan AS p
	ON sa.plan_id = p.id
    WHERE sa.transaction_status = 'success' AND p.is_regular_savings = 1
    GROUP BY sa.owner_id
)

# Final Output
SELECT u.owner_id, u.name, sa.savings_count, isv.investment_count, 
	   ROUND(COALESCE(sa.total_savings, 0) + COALESCE(isv.total_investment, 0), 2) AS total_deposits
FROM users AS u
JOIN savings AS sa ON u.owner_id = sa.owner_id
JOIN investment AS isv ON u.owner_id = isv.owner_id
ORDER BY total_deposits DESC;
