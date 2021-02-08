use temp;

drop table if exists PassHolder;
drop table if exists Resort;
drop table if exists ValidAt;

create table PassHolder(
  passID int primary key,
  name varchar(20),
  age int,
  residenceCite varchar(20),
  residenceState varchar(20)
);

create table Resort(
  resortName varchar(20) primary key,
  state varchar(2),
  baseElevation int
);

create table ValidAt(
  passID int not null,
  resortName varchar(20) not null
);

insert into PassHolder VALUES(1, "Bob", 31, "a", "MN");
insert into PassHolder VALUES(2, "Bob2", 30, "b", "CO");
insert into PassHolder VALUES(3, "Bob3", 32, "c", "CO");
insert into PassHolder VALUES(4, "Bob4", 21, "d", "CO");
insert into PassHolder VALUES(5, "Bob5", 11, "e", "CO");

insert into Resort VALUES("Vail", "CO", 2880);
insert into Resort VALUES("Vail2", "CO", 2880);
insert into Resort VALUES("Vail3", "CO", 2880);
insert into Resort VALUES("Vail4", "CO", 2880);
insert into Resort VALUES("Vail5", "CO", 2880);

insert into ValidAt VALUES(1, "Vail");
insert into ValidAt VALUES(2, "Vail");
insert into ValidAt VALUES(3, "Vail2");
insert into ValidAt VALUES(4, "Vail");
insert into ValidAt VALUES(5, "Vail");

Select S.Name, S.age from PassHolder S, ValidAt V WHERE S.passID = V.passID and S.age < 31 and V.resortName = "Vail";

Select S.Name, S.age from PassHolder S, ValidAt V WHERE S.passID = V.passID and S.age > 30 and V.resortName = "Vail";

delete from PassHolder S where S.age < 31;
Select S.Name, S.age from PassHolder S, ValidAt V WHERE S.passID = V.passID and S.age < 31 and V.resortName = "Vail";
