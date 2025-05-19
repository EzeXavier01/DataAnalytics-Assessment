# Task: Calculate the average number of transactions per customer per month and categorize them:
#"High Frequency" (≥10 transactions/month)
#"Medium Frequency" (3-9 transactions/month)
#"Low Frequency" (≤2 transactions/month)


# Getting the monthly transactions
WITH monthly_trans AS (
    SELECT owner_id, DATE_FORMAT(transaction_date, '%Y-%m') AS trans_date, COUNT(*) AS total_trans
    FROM savings_savingsaccount
    WHERE transaction_status = 'success'
    GROUP BY owner_id, trans_date
),

# Average transactions per month
avg_cus_trans AS (
    SELECT owner_id, ROUND(AVG(total_trans), 2) AS avg_total_trans
    FROM monthly_trans
    GROUP BY owner_id
)

# Categorizing users based on their transactions
SELECT
	CASE 
		WHEN avg_total_trans >= 10 THEN 'High Frequency'
		WHEN avg_total_trans >= 3 THEN 'Medium Frequency'
		ELSE 'Low Frequency'
	END AS frequency_category,
	COUNT(*) AS customer_count,
	ROUND(AVG(avg_total_trans), 1) AS avg_transactions_per_month
FROM avg_cus_trans
GROUP BY frequency_category
