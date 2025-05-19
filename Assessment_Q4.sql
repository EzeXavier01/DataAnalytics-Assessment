# Getting the customer info
WITH customer_info AS (
  SELECT 
    id,
    TIMESTAMPDIFF(MONTH, date_joined, CURRENT_DATE()) AS tenure_months,
    CONCAT(first_name, ' ', last_name) AS name
  FROM users_customuser
),

# Transaction metrics per customer
transaction_info AS (
  SELECT 
    owner_id,
    COUNT(id) AS total_transactions,
    (0.1 * SUM(confirmed_amount)) / 100 AS profit
  FROM savings_savingsaccount
  WHERE transaction_status = 'success'
  GROUP BY owner_id
)
-- Final result calculation matching original format
SELECT c.id AS customer_id, c.name, c.tenure_months, t.total_transactions,
  ROUND((t.total_transactions / c.tenure_months) * 12 * (t.profit / t.total_transactions), 2) AS estimated_clv
FROM customer_info c
JOIN transaction_info t ON c.id = t.owner_id
ORDER BY estimated_clv DESC;