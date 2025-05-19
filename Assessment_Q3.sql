# Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)

# Successful transaction date for each owner
WITH latest_transactions AS (
  SELECT plan_id, owner_id, DATE(MAX(transaction_date)) AS last_transaction_date
  FROM savings_savingsaccount
  WHERE transaction_status = 'success'
  GROUP BY plan_id, owner_id
),

active_plan_types AS (
  -- Get non-deleted plans with their type
  SELECT id AS plan_id, owner_id,
    CASE
      WHEN is_regular_savings = true THEN 'Savings'
      ELSE 'Investment'
    END AS type
  FROM plans_plan
  WHERE is_deleted = false
)
# Inactive plans (365+ days since last transaction)
SELECT p.plan_id, p.owner_id, p.type, t.last_transaction_date, 
    DATEDIFF(CURRENT_DATE(), t.last_transaction_date) AS inactivity_days
FROM active_plan_types p
JOIN latest_transactions t ON p.plan_id = t.plan_id
  AND p.owner_id = t.owner_id
WHERE DATEDIFF(CURRENT_DATE(), t.last_transaction_date) >= 365;