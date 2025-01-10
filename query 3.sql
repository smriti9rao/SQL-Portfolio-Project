--  write a query to print the transaction details(all columns from the table) for each card type when
-- it reaches a cumulative of  1,000,000 total spends(We should have 4 rows in the o/p one for each card type)

with cte as (
select *,sum(amount) over(partition by card_type order by transaction_date,transaction_id) as total_spend
from transactions.credit_card_transcations
order by card_type,total_spend 
)
select * from (select *, rank() over(partition by card_type order by total_spend) as rn  
from cte where total_spend >= 1000000) a where rn=1;
