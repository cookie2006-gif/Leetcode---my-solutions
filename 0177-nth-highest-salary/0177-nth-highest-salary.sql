-- CREATE FUNCTION function_name (param1 datatype, param2 datatype, ...)
-- RETURNS return_datatype
-- [DETERMINISTIC | NOT DETERMINISTIC]
-- BEGIN
--     -- Function body (declare variables, run queries, perform logic)
--     RETURN output_value;
-- END

create function getNthHighestSalary(N int) returns int
begin 
    return(
        with ranked as (
            select salary
            , dense_rank() over (order by salary desc) as dr
            from Employee 
        )
        select distinct salary
        from ranked
        where dr = N
);
end
