# Write your MySQL query statement below
with belongs as (
    select e.name 
        , e.salary
        , d.name as Department
    from Employee e
    left join Department d
    on e.departmentId = d.id
), ranked as (
    select name
        , salary as Salary
        , Department
        , rank() over (partition by Department order by salary desc) as rk
    from belongs
)

select Department
    , name as Employee
    , Salary
from ranked
where rk = 1
    