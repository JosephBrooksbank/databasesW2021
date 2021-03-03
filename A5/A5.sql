select 'Q1' as ' ' ;
-- (1) Find all info about managers who are 26 or younger and live in CA

SELECT E.* FROM Employee E, Manages M
WHERE E.eid = M.eid and E.age <= 26 and E.residenceState = 'CA';

# +-----+----------+------+--------+----------------+------------+
# | eid | name     | age  | salary | residenceState | startDate  |
# +-----+----------+------+--------+----------------+------------+
# |  85 | Sally85  |   21 |  41759 | CA             | 2021-09-14 |
# | 411 | Sally411 |   26 |  76422 | CA             | 2021-03-26 |
# | 545 | Sally545 |   26 |  79069 | CA             | 2021-12-17 |
# +-----+----------+------+--------+----------------+------------+


select 'Q2' as ' ' ;
-- (2) Find the name and salary of managers who earn less than 35000
SELECT E.name, E.salary FROM Employee E, Manages M
WHERE E.eid = M.eid and E.salary < 35000;

# +----------+--------+
# | name     | salary |
# +----------+--------+
# | Sally204 |  23408 |
# | Sally284 |  28465 |
# | Sally321 |  29538 |
# | Sally439 |  22562 |
# | Sally669 |  31113 |
# | Sally728 |  27451 |
# | Sally939 |  33751 |
# +----------+--------+
# 7 rows in set (0.00 sec)

select 'Q3' as ' ' ;
-- (3) Find the eid and startDate of managers who started working before Feb 1, 2021
-- i.e., startDate < "20121-02-01"

SELECT E.eid, E.startDate from Employee E
join Manages M on E.eid = M.eid # Thought I'd try it with a join instead for fun
where E.startDate < '2021-02-01';

# +-----+------------+
# | eid | startDate  |
# +-----+------------+
# | 157 | 2021-01-02 |
# | 329 | 2021-01-19 |
# +-----+------------+
# 2 rows in set (0.00 sec)


select 'Q4' as ' ' ;
-- (4) Find the name of the employee who manages the "department40" department

SELECT E.name from Employee E
JOIN Manages M on E.eid = M.eid
where M.did = 40; # Could have joined with department to get it explicitly, but this is faster

# +----------+
# | name     |
# +----------+
# | Sally948 |
# +----------+
# 1 row in set (0.00 sec)


select 'Q5' as ' ' ;
-- (5) Find the eid of employees who work in exactly 3 departments
-- Hint: use aggregates/group by/having
SELECT E.eid from Employee E
join WorksFor WF on E.eid = WF.eid
group by E.eid
having count(*) = 3;

# +-----+
# | eid |
# +-----+
# |  94 |
# | 123 |
# | 262 |
# | 293 |
# | 684 |
# | 922 |
# | 971 |
# +-----+
# 7 rows in set (0.00 sec)

select 'Q6' as ' ' ;
-- (6) Find the eid, residenceState, and did for all those 20 year old
-- employees that work in a department located in the same state that they live in.
SELECT E.eid, E.residenceState, D.did FROM Employee E
join WorksFor WF on E.eid = WF.eid
join Department D on WF.did = D.did
WHERE E.age = 20 and E.residenceState = D.stateLocated;

# +-----+----------------+-----+
# | eid | residenceState | did |
# +-----+----------------+-----+
# | 678 | HI             |  35 |
# +-----+----------------+-----+
# 1 row in set (0.00 sec)

select 'Q7' as ' ' ;
-- (7) Find the eid, residence state, did, and department state
-- for every managers who manages a department located in AK

SELECT E.eid, E.residenceState, D.did, D.stateLocated
FROM Employee E
join Manages M on E.eid = M.eid
join Department D on M.did = D.did
where D.stateLocated =  'AK';

# +-----+----------------+-----+--------------+
# | eid | residenceState | did | stateLocated |
# +-----+----------------+-----+--------------+
# | 247 | AZ             |  16 | AK           |
# | 618 | AZ             |  24 | AK           |
# |  46 | KY             |  44 | AK           |
# +-----+----------------+-----+--------------+
# 3 rows in set (0.00 sec)




select 'Q8' as ' ' ;
-- (8) Find the eid, residence state, did, and deparment state for
-- every employee that works for a department located in CO

SELECT E.eid, E.residenceState, D.did, D.stateLocated FROM Employee E, Department D, WorksFor W
WHERE E.eid = W.eid and D.did = W.did and D.stateLocated = 'CO';

# +-----+----------------+-----+--------------+
# | eid | residenceState | did | stateLocated |
# +-----+----------------+-----+--------------+
# |  76 | DE             |  41 | CO           |
# | 121 | FL             |  41 | CO           |
# | 168 | AZ             |  41 | CO           |
# | 254 | DE             |  41 | CO           |
# | 258 | ME             |  41 | CO           |
# | 283 | KY             |  41 | CO           |
# | 341 | HI             |  41 | CO           |
# | 346 | DE             |  41 | CO           |
# | 358 | KS             |  41 | CO           |
# | 367 | KS             |  41 | CO           |
# | 486 | AZ             |  41 | CO           |
# | 522 | IN             |  41 | CO           |
# | 529 | IN             |  41 | CO           |
# | 569 | FL             |  41 | CO           |
# | 673 | IA             |  41 | CO           |
# | 744 | CO             |  41 | CO           |
# | 815 | ID             |  41 | CO           |
# | 909 | CO             |  41 | CO           |
# | 930 | LA             |  41 | CO           |
# | 956 | IA             |  41 | CO           |
# | 968 | KY             |  41 | CO           |
# |  25 | HI             |  43 | CO           |
# |  67 | AZ             |  43 | CO           |
# |  98 | CO             |  43 | CO           |
# | 144 | AL             |  43 | CO           |
# | 332 | AK             |  43 | CO           |
# | 335 | LA             |  43 | CO           |
# | 438 | DE             |  43 | CO           |
# | 490 | DE             |  43 | CO           |
# | 510 | FL             |  43 | CO           |
# | 514 | IN             |  43 | CO           |
# | 622 | CT             |  43 | CO           |
# | 640 | CO             |  43 | CO           |
# | 660 | IA             |  43 | CO           |
# | 695 | AL             |  43 | CO           |
# | 732 | DE             |  43 | CO           |
# | 734 | CO             |  43 | CO           |
# | 787 | AZ             |  43 | CO           |
# | 841 | KS             |  43 | CO           |
# | 910 | ME             |  43 | CO           |
# | 978 | AZ             |  43 | CO           |
# | 995 | AZ             |  43 | CO           |
# +-----+----------------+-----+--------------+
# 42 rows in set (0.00 sec)

select 'Q9' as ' ' ;
-- (Q9) find the eid of employees who are managing two or more departments
SELECT E.eid from Employee E, Manages M
where E.eid = M.eid
group by E.eid
having count(*) >= 2;

# +-----+
# | eid |
# +-----+
# | 627 |
# | 948 |
# +-----+
# 2 rows in set (0.00 sec)





select 'Q10' as ' ' ;
-- (Q10) find eid, did, and manging starting date for all employees found in the previous problem
-- Hint: use "in" and a nested query

SELECT E.eid, M.did, M.dateStartedManaging
from Employee E
join Manages M on E.eid = M.eid
WHERE E.eid in
  (
    SELECT E.eid from Employee E, Manages M
                where E.eid = M.eid
                group by E.eid
                having count(*) >= 2
    );

# +-----+-----+---------------------+
# | eid | did | dateStartedManaging |
# +-----+-----+---------------------+
# | 627 |   6 | 2021-11-13          |
# | 627 |  27 | 2021-10-28          |
# | 948 |  36 | 2021-03-03          |
# | 948 |  40 | 2021-01-13          |
# +-----+-----+---------------------+
# 4 rows in set (0.00 sec)


select 'Q11' as ' ' ;
-- (11) find the did and number of employees for every department with 14 or fewer employees

SELECT WF.did, COUNT(*) from WorksFor WF
group by WF.did
having count(*) <= 14;


# +-----+----------+
# | did | COUNT(*) |
# +-----+----------+
# |   1 |       11 |
# |   3 |       13 |
# |   8 |       14 |
# |  32 |       13 |
# +-----+----------+
# 4 rows in set (0.00 sec)


-- (12) Find the average employee salary for each department whose did is < 6.
-- In other words, for each of those departments find the average salary of employees
-- who work for that department

Select WF.did, AVG(E.salary) from Employee E
join WorksFor WF on E.eid = WF.eid
where WF.did < 6
group by WF.did;


# +-----+-------------------+
# | did | AVG(E.salary)     |
# +-----+-------------------+
# |   1 | 53461.09090909091 |
# |   2 | 50880.28571428572 |
# |   3 | 57662.38461538462 |
# |   4 | 51728.80952380953 |
# |   5 |             51007 |
# +-----+-------------------+
# 5 rows in set (0.00 sec)
