select date_format(trans_date, '%Y-%m') as month
    , country
    , count(*) as trans_count
    , sum(if(state = 'approved', 1, 0)) as approved_count
    # , count(case when state = 'approved' then 1 else 0) as approved_count
    # , count(if(state = 'approved', 1, null)) approved_count
    , sum(amount) as trans_total_amount
    , sum(if (state = 'approved', amount, 0)) as approved_total_amount
from Transactions
group by month, country