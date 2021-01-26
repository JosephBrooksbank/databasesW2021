Use LCS;
create table Teams (
  teamID int;
  name varchar(30);
  seriesWon int;
  seriesLost int; 
);

create table Top3 (
  playerID int;
  top varchar(20);
  second varchar(20);
  third varchar(20);

create table Players (
  playerID int;
  name varchar(30);
  salary int;
  startDate date;
);

create table Coaches (
  coachID int;
  name varchar(30);
  startDate date;
  salary int;
);

create table Games (
  gameID int;
  lengthGame time;
);

create table Series (
  seriesID int;
  seriesDate date;
  score varchar(3);
);

