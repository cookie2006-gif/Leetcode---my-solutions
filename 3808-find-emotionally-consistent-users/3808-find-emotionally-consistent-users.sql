with reaction_count as (
    select user_id
        , reaction
        , count(*) as cnt
    from reactions 
    group by user_id, reaction
), ranked as (
    select user_id
        , reaction
        , cnt
        , sum(cnt) over (partition by user_id) as total
        , row_number() over (partition by user_id order by cnt desc) as rn
    from reaction_count
)

select user_id
    , reaction as dominant_reaction
    , round(cnt / total, 2) as reaction_ratio
from ranked
where rn = 1 and total >= 5 and cnt / total >= 0.6
order by reaction_ratio desc, user_id asc;