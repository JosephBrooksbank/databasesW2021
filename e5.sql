# Q1: find all attributes/fields of each 18 year old sailor whose rating is 8 or greater

select 'Query 1' as ' ' ;
select * from sailors S
where S.age = 18 and S.rating > 8;
 

# Q2: find the first reservation (i.e. lowest rdate) for each sailors with ids less than 5

select 'Query 2' as ' ' ;
select sid, Min(rdate) from reserve R group by R.sid having R.sid < 5;


# Q3: find the number of reservations by 18 year old sailors

select 'Query 3' as ' ' ;
select count(*) from reserve join sailors on sailors.sid = reserve.sid where sailors.age = 18;

# Q4: Find the sailor name, age and boat name for all reservations on 2021-06-01 made by sailors we are 90 years old or older.  Show the results sorted by age

select 'Query 4' as ' ' ;

select S.name, S.age, B.name from sailors S, boats B, reserve R where S.sid = R.sid and B.bid = R.bid and S.age > 90 and R.rdate = "2021-06-01" order by S.age;
 

# Q5: find all attributes/fields of boats that are "lime" color and have a ratingNeeded that is the maximum of all ratingNeeded for all boats.

select 'Query 5' as ' ' ;
select * from boats B where B.bcolor = "lime" and B.ratingNeeded = (select Max(ratingNeeded) from boats);
 

##### For the following questions (Q6A - Q6F),

# Lets define an "invalid reservation" to be one where the sailors rating is less than

# the reserved boat's ratingNeeded.

 

# Q6A:  Print the (sid, name, age, and sailor rating) of 18 year old sailors

select 'Query 6A' as ' ' ;
select S.sid, S.name, S.age, S.rating from sailors S where S.age = 18;
 

# Q6B:  Print the (sid, name, age, and sailor rating) of sailors who have

# made one or more invalid reservations

select 'Query 6B' as ' ' ;
select s.sid, s.name, s.age, s.rating from sailors s
inner join reserve r on s.sid = r.sid 
inner join boats b on r.bid = b.bid
where s.rating < b.ratingNeeded and s.age = 18
group by s.sid;

# Q6C:  Print the (sid, name, age, and sailor rating) of sailors who

# have made one or more invalid reservations

select 'Query 6C' as ' ' ;

select s.sid, s.name, s.age, s.rating from sailors s
inner join reserve r on s.sid = r.sid 
inner join boats b on r.bid = b.bid
where s.rating < b.ratingNeeded and s.age = 18
group by s.sid;

# Q6D:  Print the (sid, name, age, and sailor rating) of sailors who

# have NOT made any invalid reservations
# I am in severe pain

select distinct S.sid, S.name, S.age, S.rating from sailors S
inner join reserve R on S.sid = R.sid
inner join boats B on R.bid = B.bid
where S.age = 18
and  S.sid not in (
select S2.sid
from sailors S2, boats B2, reserve R2
where S2.sid = R2.sid and R2.bid = B2.bid and S2.age = 18 and S2.rating < B2.ratingNeeded
) ;


# Q6E:

# Print the following reservation information

# (sid, name, age, sailor rating, bid, and boat ratingNeeded)

# for all reservations made by 18 year old sailors who have made one

# or more "invalid" reservations.

# Sort the results by sid

# Note - this should include valid and invalid reservations by such sailors

select 'Query 6E' as ' ' ;
select distinct S.sid, S.name, S.age, S.rating, B.bid, B.ratingNeeded
from sailors S, boats B, reserve R
where S.sid = R.sid and R.bid = B.bid and S.age = 18
and  S.sid in (
select S2.sid
from sailors S2, boats B2, reserve R2
where S2.sid = R2.sid and R2.bid = B2.bid and S2.age = 18 and S2.rating < B2.ratingNeeded
);

# Q6F:  Print the reservation & sailor information

# (sid, name, age, sailor rating, # bid, and boat ratingNeeded) for

# "invalid" reservations by 18 year old sailors.

# Sort the results by sid

# Note, this should be a subset of the preceeding query

select 'Query 6F' as ' ' ;

select 'Query 6E' as ' ' ;
select distinct S.sid, S.name, S.age, S.rating, B.bid, B.ratingNeeded
from sailors S, boats B, reserve R
where S.sid = R.sid and R.bid = B.bid and S.age = 18 and S.rating < B.ratingNeeded;

# Q7: for each 18 year sailor that has made one or more invalid reservations,

# return the sailor's and the number of these "invalid" reservations they have made.

# Order by sid

select 'Query 7' as ' ' ;

select S.sid, COUNT(*)
from sailors S, boats B, reserve R
where S.sid = R.sid and R.bid = B.bid and S.age = 18 and S.rating < B.ratingNeeded
group by S.sid;

# Q8: find avg rating and the number of sailors in the group for each age group

# of sailors that are 31..39 years old inclusive

select 'Query 8' as ' ' ;
select COUNT(*), S.age, AVG(S.rating)
from sailors S
where age >= 31 and age <= 39
group by S.age
order by S.age;

# Q9: find avg rating and the number of sailors in the group for each age group of sailors that are 31..39 years, but, only include groups that have 6 or more sailors of that age

select 'Query 9' as ' ' ;

select 'Query 8' as ' ' ;
select COUNT(*), S.age, AVG(S.rating)
from sailors S
where age >= 31 and age <= 39
group by S.age
having COUNT(*) >= 6
order by S.age;
# its finally over
# its done


