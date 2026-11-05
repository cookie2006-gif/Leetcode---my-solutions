-- select distinct l1.num as ConsecutiveNums
-- from Logs l1
-- join Logs l2 on l1.id = l2.id - 1
-- join Logs l3 on l1.id = l3.id - 2
-- where l1.num = l2.num and l2.num = l3.num

with ranked as (
    select num
        , lead(num, 1) over (order by id) as next_num
        , lead(num, 2) over (order by id) as next_next_num
    from Logs
)
select distinct num as ConsecutiveNums
from ranked
where num = next_num and num = next_next_num