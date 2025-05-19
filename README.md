# DataAnalytics-Assessment
## Question 1 - Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits
### SOLUTION
* The first step of my cte required me to concatinate the first name and last name of the user as the were in different columns
* My next approach was to get users with the investment plan and also savings plan in a different cte
* My third and final step to this question was to get all the cte together and query out my final result.
  
## SUMMARY, CHALLENGES AND FINDINGS
My approach to this question was to treat each aspect individually, first getting the fullname of the users, the investment and saving records then combining them all together.
I also noticed there were failed transactions that were included in the results going through the savings_savingaccount table, so I had to only select rows with their transaction successful.
The challenges I had at first was understanding the ERD of the tables as there were no data dictionary, as I had a issues deciding between the columns, is_fixed_investment and is_a_fund for my investment plan but decided to go with the former.

## Question 2 -  Calculate the average number of transactions per customer per month and categorize them:
- "High Frequency" (≥10 transactions/month)
- "Medium Frequency" (3-9 transactions/month)
- "Low Frequency" (≤2 transactions/month)
### SOLUTION
* My first step was getting the monthly "SUCCESSFUL" transactions.
* Then I calculated the average transaction for per customers per month,
* Then my last step was to categorize the average total transaction by their category

## SUMMARY, CHALLENGES AND FINDINGS
My approach to this question was basically direct, by seperating the problems into steps. Firstly getting the monthly transactions in a table, then calculating the average number of transactions, after that, I was able to categorize them according to their frequency.
The issue I had was based off on validation of my final result, checking the average transactions of a customer per month and calculating if the output was correct(Used one customer ID as a test case)

## Question 3 - Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)

### SOLUTION
* Created a CTE to identify the most recent "SUCCESSFUL" transaction of a customer
* Created a CTE to categorize each plan as either "Savings" or "Investment" based on the is_regular_savings flag.
* Join the two CTEs to combine plan type information with latest transaction dates and used a DATEDIFF() to calculate days since last transaction and filtered for accounts 
 where inactivity exceeds 365 days.

## SUMMARY, CHALLENGES AND FINDINGS
The final result set includes the neccessary columns  and the exact number of days of inactivity, helping identify inactive accounts that may require attention.

## Question 4 - For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:

### SOLUTION
* Created a CTE to extract basic customer data, also calculate tenure in months using TIMESTAMPDIFF() between join date and current date and also combined the first name and 
  last name columns
* Created a CTE to analyze transaction history per customer and also count the total successful transactions for each customer.
* Joined the customer information with transaction metrics and calculated CLV using the formula: (transactions per month) × 12 × (average profit per transaction)

## SUMMARY, CHALLENGES AND FINDINGS
My final result set provides a comprehensive view of each customer's value to the business, helping to identify which customers generate the most profit over time.
