with FirstLogin as (
    select player_id
        , min(event_date) as first_date
    from Activity
    group by player_id
)

select round((count(distinct a.player_id)/(select count(distinct player_id) from Activity)), 2) as fraction
from FirstLogin f
join Activity a 
on f.player_id = a.player_id 
and a.event_date = date_add(f.first_date, interval 1 day)

