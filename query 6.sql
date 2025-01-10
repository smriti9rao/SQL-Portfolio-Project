-- write a query to find percentage contribution of spends by females for each expense type


select exp_type,
sum(case when gender='F' then amount else 0 end)*1.0/sum(amount) as percentage_female_contribution
from transactions.credit_card_transcations
group by exp_type
order by percentage_female_contribution desc
limit 5;