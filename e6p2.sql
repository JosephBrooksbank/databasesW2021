drop procedure if exists proc_e6;
delimiter //
create procedure proc_e6()
begin
    select E.salary from Employee E
    join Manages M on E.eid = M.eid;

    SELECT MAX(E.salary) from Employee E
    where E.eid not in (
        SELECT  E2.eid from Employee E2, Manages M2
        where E2.eid = M2.eid
        ) into @MaxNonManager;

    UPDATE Employee E Set salary = @MaxNonManager + 1
    where E.eid in ( select M.eid from Manages M) and E.salary < @MaxNonManager;

    select E.salary from Employee E
    join Manages M on E.eid = M.eid;
end //
delimiter ;