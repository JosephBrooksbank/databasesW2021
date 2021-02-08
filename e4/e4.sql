use e4;


drop table if exists Employee;
drop table if exists Project;
drop table if exists WorksOn;
create table Employee(
  eid int,
  name varchar(20),
  age int,
  salary int,
  Primary Key (eid)
);

create table Project(
  pid int,
  pname varchar(20),
  budget int,
  Primary Key (pid)
);

create table WorksOn(
  eid int,
  pid int,
  since date,
  Primary Key (eid,pid),
  Foreign Key (eid) references Employee(eid),
  Foreign Key (pid) references Project(pid)
);

insert into Employee values(1,'Anita',30,40000);

insert into Employee values(2,'Anant',28,80000);

insert into Employee values(3,'Michelle',32,60000);

insert into Employee values(4,'Michael',30,90000);

insert into Employee values(5,'Patricia',40,80000);

insert into Employee values(6,'Patrick',41,100000);



insert into Project values(101,'SuperSurveil',1000000) ;

insert into Project values(102,'HelpAllPeople',10000) ;

insert into Project values(103,'BernieMemeGeneration',500000) ;

insert into Project values(104,'CatMemeGeneration',2000000) ;



insert into WorksOn values(6,101,'2021-01-22') ;

insert into WorksOn values(1,101,'2021-01-30') ;

insert into WorksOn values(1,102,'2021-01-30') ;

insert into WorksOn values(2,101,'2021-01-15') ;

insert into WorksOn values(3,102,'2020-05-15') ;

insert into WorksOn values(4,102,'2020-08-15') ;

insert into WorksOn values(5,103,'2021-01-22') ;

insert into WorksOn values(6,103,'2021-01-22') ;



select * from Employee ;

select * from Project  ;

select * from WorksOn  ;


Select S.eid, S.name from Employee S, WorksOn W
  Where S.eid = W.eid and W.pid = 101;

Select S.eid, S.name from Employee S, WorksOn W
  Where S.eid = W.eid and W.pid = 103;


Select S.eid, S.name from Employee S, WorksOn W
  Where S.eid = W.eid and W.pid = 101
  
  Union

Select S.eid, S.name from Employee S, WorksOn W
  Where S.eid = W.eid and W.pid = 103;

Select S.eid, S.name from Employee S, WorksOn W1
   where S.eid = W1.eid and W1.pid = 101 and W1.eid in (
    select W2.eid from WorksOn W2 
     where W2.pid = 103);


Select S.eid, S.name from Employee S, WorksOn W1
   where S.eid = W1.eid and W1.pid = 101 and W1.eid not in (
    select W2.eid from WorksOn W2 
     where W2.pid = 103);
