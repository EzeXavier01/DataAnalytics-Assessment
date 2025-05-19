# DataAnalytics-Assessment
## Question 1 - Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits
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
