# Write your MySQL query statement below
with cnt as (
    select managerId
    from Employee
    group by managerId
    having count(*) >= 5
)
select e.Name as name
from cnt c
join Employee e 
on e.id = c.managerId