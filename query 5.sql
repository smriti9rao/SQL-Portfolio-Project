-- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)

select distinct exp_type from transactions.credit_card_transcations;
with cte as (
select city,exp_type, sum(amount) as total_amount from transactions.credit_card_transcations
group by city,exp_type)
select
city , max(case when rn_asc=1 then exp_type end) as lowest_exp_type
, min(case when rn_desc=1 then exp_type end) as highest_exp_type
from
(select *
,rank() over(partition by city order by total_amount desc) rn_desc
,rank() over(partition by city order by total_amount asc) rn_asc
from cte) A
group by city
limit 5;