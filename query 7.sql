-- which card and expense type combination saw highest month over month growth in Jan-2014
WITH MonthlyTotals AS (
    SELECT 
        YEAR(STR_TO_DATE(transaction_date, '%m/%d/%Y')) AS year,
        MONTH(STR_TO_DATE(transaction_date, '%m/%d/%Y')) AS month,
        card_type,
        exp_type,
        SUM(amount) AS total_amount
    FROM 
        transactions.credit_card_transcations
    GROUP BY 
        YEAR(STR_TO_DATE(transaction_date, '%m/%d/%Y')),
        MONTH(STR_TO_DATE(transaction_date, '%m/%d/%Y')),
        card_type,
        exp_type
),
MonthOverMonthGrowth AS (
    SELECT 
        t1.card_type,
        t1.exp_type,
        t1.total_amount AS jan_2014_amount,
        t2.total_amount AS dec_2013_amount,
        ((t1.total_amount - t2.total_amount) / NULLIF(t2.total_amount, 0)) * 100 AS growth_percentage
    FROM 
        MonthlyTotals t1
    LEFT JOIN 
        MonthlyTotals t2
    ON 
        t1.card_type = t2.card_type
        AND t1.exp_type = t2.exp_type
        AND t1.year = 2014 AND t1.month = 1
        AND t2.year = 2013 AND t2.month = 12
)
SELECT 
    card_type,
    exp_type,
    growth_percentage
FROM 
    MonthOverMonthGrowth
ORDER BY 
    growth_percentage DESC
LIMIT 1;
