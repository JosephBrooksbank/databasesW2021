Use LCS;

drop table if exists Teams;
drop table if exists TopThree;
drop table if exists Players;
drop table if exists Coaches;
drop table if exists Games;
drop table if exists Series;
drop table if exists TradedPlayers;
drop table if exists TeamCompetesInSeries;
drop table if exists TeamCompetesInGames;
drop table if exists PlayerCompetesInSeries;
drop table if exists PlayerCompetesInGame;

create table Teams (
  teamID varchar(5) primary key,
  name varchar(30),
  seriesWon int,
  seriesLost int
);

create table TopThree (
  playerID int primary key,
  top varchar(20),
  second varchar(20),
  third varchar(20)
);

create table Players (
  playerID int primary key,
  name varchar(30),
  salary int,
  startDate date,
  teamID varchar(5)
);

create table Coaches (
  coachID int primary key,
  name varchar(30),
  startDate date,
  salary int,
  teamID varchar(5)
);

create table Games (
  gameID int primary key,
  lengthGame time,
  seriesID int
);

create table Series (
  seriesID int primary key,
  seriesDate date,
  score varchar(20)
);

create table TradedPlayers (
  team1ID varchar(5),
  team2ID varchar(5),
  playerID int,
  cost int,
  date date
);

create table TeamCompetesInSeries(
  teamID varchar(5),
  seriesID int,
  won int
);

create table TeamCompetesInGames(
  teamID varchar(5),
  gameID int,
  won int
);

create table PlayerCompetesInSeries(
  playerID int,
  seriesID int,
  won int
);

create table PlayerCompetesInGame(
  playerID int,
  gameID int,
  won int
);


