with trip_efficiency as (
    select
        driver_id,
        month(trip_date) as trip_month,
        distance_km / fuel_consumed as efficiency
    from trips
),
half_averages as (
    select
        driver_id,
        avg(case when trip_month between 1 and 6 then efficiency end) as first_half_avg,
        avg(case when trip_month between 7 and 12 then efficiency end) as second_half_avg
    from trip_efficiency
    group by driver_id
    having first_half_avg is not null 
       and second_half_avg is not null
)
select
    d.driver_id,
    d.driver_name,
    round(h.first_half_avg, 2) as first_half_avg,
    round(h.second_half_avg, 2) as second_half_avg,
    round(h.second_half_avg - h.first_half_avg, 2) as efficiency_improvement
from half_averages h
join drivers d on d.driver_id = h.driver_id
where h.second_half_avg > h.first_half_avg
order by efficiency_improvement desc, driver_name asc;