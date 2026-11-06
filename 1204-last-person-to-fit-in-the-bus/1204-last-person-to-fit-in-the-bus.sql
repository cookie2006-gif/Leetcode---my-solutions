-- Write your PostgreSQL query statement below
with total_weight as (
    select turn
        , person_name
        , sum(weight) over (order by turn asc) as total
    from Queue
)

select person_name
from total_weight
where total <= 1000
order by turn desc limit 1