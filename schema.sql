Use LCS;

drop table if exists TopThree;
drop table if exists Coaches;
drop table if exists TeamCompetesInSeries;
drop table if exists TeamCompetesInGame;
drop table if exists PlayerCompetesInSeries;
drop table if exists PlayerCompetesInGame;
drop table if exists Games;
drop table if exists Series;
drop table if exists Players;
drop table if exists Teams;

create table Teams (
  teamID varchar(5) primary key,
  name varchar(30),
  seriesWon int,
  seriesLost int
);

create table Players (
  playerID int primary key,
  name varchar(30),
  salary int,
  startDate date,
  teamID varchar(5),
  Foreign Key (teamID) references Teams(teamID)
);

create table TopThree (
  playerID int primary key,
  top varchar(20),
  second varchar(20),
  third varchar(20),
  Foreign Key (playerID) references Players(playerID)
);

create table Coaches (
  coachID int primary key,
  name varchar(30),
  salary int,
  startDate date,
  teamID varchar(5),
  Foreign Key (teamID) references Teams(teamID)
);

create table Series (
  seriesID int primary key,
  seriesDate date,
  score varchar(20)
);

create table Games (
  gameID int,
  lengthGame time,
  seriesID int,
  Primary Key (gameID, seriesID),
  Foreign Key (seriesID) references Series(seriesID),
  index(lengthGame)
);

create table TeamCompetesInSeries(
  teamID varchar(5),
  seriesID int,
  won varchar(4),
  Primary Key (teamID, seriesID),
  Foreign Key (teamID) references Teams(teamID),
  Foreign Key (seriesID) references Series(SeriesID)
);

create table TeamCompetesInGame(
  teamID varchar(5),
  gameID int,
  won varchar(4),
  Primary Key (teamID, gameID),
  Foreign Key (teamID) references Teams(teamID),
  Foreign Key (gameID) references Games(gameID)
);

create table PlayerCompetesInSeries(
  playerID int,
  seriesID int,
  won varchar(4),
  Primary Key (playerID, seriesID),
  Foreign Key (playerID) references Players(playerID),
  Foreign Key (seriesID) references Series(seriesID)
);

create table PlayerCompetesInGame(
  playerID int,
  gameID int,
  won varchar(4),
  Primary Key (playerID, gameID),
  Foreign Key (playerID) references Players(playerID),
  Foreign Key (gameID) references Games(gameID),
  index(won)
);

load data local infile 'data_teams' into table Teams
    fields terminated by ','
    lines terminated by '\n';


load data local infile 'data_coach' into table Coaches
    fields terminated by ','
    lines terminated by '\n';

load data local infile 'data_player' into table Players
    fields terminated by ','
    lines terminated by '\n';

load data local infile 'data_series' into table Series
    fields terminated by ','
    lines terminated by '\n';

load data local infile 'data_games' into table Games
    fields terminated by ','
    lines terminated by '\n';

load data local infile 'data_playerInSeries' into table PlayerCompetesInSeries
    fields terminated by ','
    lines terminated by '\n';

load data local infile 'data_playerInGame' into table PlayerCompetesInGame
    fields terminated by ','
    lines terminated by '\n';

load data local infile 'data_teamInGame' into table TeamCompetesInGame
    fields terminated by ','
    lines terminated by '\n';

load data local infile 'data_teamInSeries' into table TeamCompetesInSeries
    fields terminated by ','
    lines terminated by '\n';

load data local infile 'data_favChamps' into table TopThree
    fields terminated by ','
    lines terminated by '\n';



