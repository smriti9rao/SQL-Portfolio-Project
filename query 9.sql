-- which city took least number of days to reach its
-- 500th transaction after the first transaction in that city;

WITH FirstTransactionDate AS (
    SELECT 
        city,
        MIN(STR_TO_DATE(transaction_date, '%m/%d/%Y')) AS first_transaction_date
    FROM 
        transactions.credit_card_transcations
    GROUP BY 
        city
),
TransactionDays AS (
    SELECT 
        t.city,
        STR_TO_DATE(t.transaction_date, '%m/%d/%Y') AS transaction_date,
        ROW_NUMBER() OVER (PARTITION BY t.city ORDER BY STR_TO_DATE(t.transaction_date, '%m/%d/%Y')) AS transaction_number
    FROM 
        transactions.credit_card_transcations t
),
City500thTransaction AS (
    SELECT 
        td.city,
        DATEDIFF(td.transaction_date, ft.first_transaction_date) AS days_to_500th_transaction
    FROM 
        TransactionDays td
    JOIN 
        FirstTransactionDate ft
    ON 
        td.city = ft.city
    WHERE 
        td.transaction_number = 500
)
SELECT 
    city,
    days_to_500th_transaction AS datediff
FROM 
    City500thTransaction
ORDER BY 
    datediff ASC
LIMIT 1;


