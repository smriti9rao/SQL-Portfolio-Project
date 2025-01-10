select* from transactions.credit_card_transcations;

-- write a query to print top 5 cities with highest spends 
-- and their percentage contribution of total credit card spends

WITH cte1 AS (
    SELECT city, SUM(amount) AS total_spend
    FROM transactions.credit_card_transcations
    GROUP BY city
),
total_spent AS (
    SELECT SUM(amount) AS total_amount
    FROM transactions.credit_card_transcations
)
SELECT 
    cte1.*, 
    ROUND(cte1.total_spend * 1.0 / total_spent.total_amount * 100, 2) AS percentage_contribution
FROM 
    cte1 
CROSS JOIN 
    total_spent
ORDER BY 
    total_spend DESC
LIMIT 5;
