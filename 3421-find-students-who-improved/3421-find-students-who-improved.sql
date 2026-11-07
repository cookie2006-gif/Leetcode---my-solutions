# Write your MySQL query statement below
with ranked as (
    select student_id
        , subject
        , score
        , row_number() over (partition by student_id, subject order by exam_date asc) as rn_asc
        , row_number() over (partition by student_id, subject order by exam_date desc) as rn_desc
    from Scores
)

select f.student_id
    , f.subject
    , f.score as first_score
    , l.score as latest_score
from ranked f 
join ranked l 
on f.student_id = l.student_id
and f.subject = l.subject
and f.rn_asc = 1
and l.rn_desc = 1
where f.rn_desc > 1
and l.score > f.score
order by f.student_id asc, f.subject asc



