-- during weekends which city has highest total spend to total no of transcations ratio 

SELECT 
    city, 
    SUM(amount) * 1.0 / COUNT(1) AS ratio
FROM 
    transactions.credit_card_transcations
WHERE 
    DAYOFWEEK(transaction_date) IN (1, 7) -- 1 = Sunday, 7 = Saturday
GROUP BY 
    city
ORDER BY 
    ratio DESC
LIMIT 1;

