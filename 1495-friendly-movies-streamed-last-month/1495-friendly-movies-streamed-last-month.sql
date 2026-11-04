select distinct c.title 
from Content c
join TVProgram t 
on c.content_id = t.content_id
where c.Kids_content = 'Y' and c.content_type = 'Movies' and t.program_date like '%2020-06%'

