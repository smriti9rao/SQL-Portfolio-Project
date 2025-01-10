--  write a query to print highest spend month and amount spent in that month for each card type

WITH monthly_spend AS (
    SELECT 
        card_type,
        YEAR(transaction_date) AS year,
        MONTH(transaction_date) AS month,
        SUM(amount) AS total_spend
    FROM 
        transactions.credit_card_transcations
    WHERE 
        transaction_date IS NOT NULL 
        AND YEAR(transaction_date) IS NOT NULL 
        AND MONTH(transaction_date) IS NOT NULL
    GROUP BY 
        card_type, YEAR(transaction_date), MONTH(transaction_date)
),
ranked_spend AS (
    SELECT 
        card_type,
        year,
        month,
        total_spend,
        RANK() OVER (PARTITION BY card_type ORDER BY total_spend DESC) AS `rank`
    FROM 
        monthly_spend
)
SELECT 
    card_type,
    CONCAT(year, '-', LPAD(month, 2, '0')) AS highest_spend_month,
    total_spend AS amount_spent
FROM 
    ranked_spend
WHERE 
    `rank` = 1;




