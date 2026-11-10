# Write your MySQL query statement below
with all_friends as (
    select requester_id as id from requestaccepted
    union all
    select accepter_id as id from requestaccepted
)
select 
    id, 
    count(*) as num
from all_friends
group by id
order by num desc
limit 1;