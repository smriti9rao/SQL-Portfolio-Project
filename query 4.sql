--  write a query to find city which had lowest percentage spend for gold card type
WITH cte as (
    SELECT 
        city,
        card_type,
        SUM(amount) as amount,
        SUM(CASE WHEN card_type = 'Gold' THEN amount END) as gold_amount,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY SUM(amount) DESC) as rn
    FROM 
        transactions.credit_card_transcations
    GROUP BY 
        city, card_type
)
SELECT 
    city,
    SUM(gold_amount) * 1.0 / SUM(amount) as gold_ratio
FROM 
    cte
WHERE 
    rn = 1 
GROUP BY 
    city
HAVING 
    COUNT(gold_amount) > 0 AND SUM(gold_amount) > 0
ORDER BY 
    gold_ratio
    limit 1;

