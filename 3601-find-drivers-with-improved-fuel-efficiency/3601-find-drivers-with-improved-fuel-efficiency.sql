with first as (
    select driver_id
        , avg(distance_km / fuel_consumed) as first_half_avg
    from trips
    where trip_date <= '2023-06-30'
    group by driver_id
), second as (
    select driver_id
        , avg(distance_km / fuel_consumed) as second_half_avg
    from trips
    where trip_date >= '2023-07-01'
    group by driver_id
)
select d.driver_id
    , d.driver_name
    , round(f.first_half_avg, 2) as first_half_avg
    , round(s.second_half_avg, 2) as second_half_avg
    , round((s.second_half_avg - f.first_half_avg), 2) as efficiency_improvement
from drivers d
join first f
on d.driver_id = f.driver_id
join second s
on d.driver_id = s.driver_id
where f.first_half_avg < s.second_half_avg
order by efficiency_improvement desc, driver_name asc


