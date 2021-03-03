# Foreign Key (teamID) references Teams(teamID)
# I don't realy know what more the assigments for the
# 'show the create table statement that defines these foreign key constraints'
# There are foreign key statements in many of the create tables, the above is a sample

# UPDATE Players P SET P.teamID = "fake" WHERE teamID = 1;
# Output:
# [2021-02-28 14:03:02] [23000][1452] Cannot add or update a child row: a foreign key constraint fails (`LCS`.`Players`, CONSTRAINT `Players_ibfk_1` FOREIGN KEY (`teamID`) REFERENCES `Teams` (`teamID`))

# 2 procedure: Creates a game in a series between two teams, and adds the game to the series and TeamCompetesInGame
# I didn't see that we could do it in python until it was too late to turn back, sorry you have to read the following

SELECT * From Games G Where G.gameID in (SELECT MAX(G2.gameID) from Games G2);
# Output:
# +--------+------------+----------+
# | gameID | lengthGame | seriesID |
# +--------+------------+----------+
# |   8027 | 00:00:22   |        1 |
# +--------+------------+----------+

drop procedure if exists add_game;
delimiter //
create procedure add_game(
IN series int,
IN length time,
IN team1 varchar(5),
IN team2 varchar(5),
IN won varchar(5)
)
BEGIN
    SET @gameID = (SELECT MAX(G.gameID) from Games G) + 1;

    INSERT INTO Games (gameID, lengthGame, seriesID) VALUES (@gameID, length, series);
    IF won = team1 THEN
        INSERT INTO TeamCompetesInGame (teamID, gameID, won) VALUES (team1, @gameID, "won");
        INSERT INTO TeamCompetesInGame (teamID, gameID, won) VALUES (team2, @gameID, "lost");

    ELSEIF won = team2 THEN
        INSERT INTO TeamCompetesInGame (teamID, gameID, won) VALUES (team2, @gameID, "won");
        INSERT INTO TeamCompetesInGame (teamID, gameID, won) VALUES (team1, @gameID, "lost");

    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'parameter for winning team does not match a team';
    end if;
end //
delimiter ;
call add_game(1, "00:00:32", 1,2,1);

# Output:
# [2021-02-28 14:36:24] 1 row(s) affected in 8 ms
# [2021-02-28 14:36:24] Summary: 5 of 5 statements executed in 194 ms (1,059 symbols in file)

SELECT * From Games G Where G.gameID in (SELECT MAX(G2.gameID) from Games G2);
# Output:
# +--------+------------+----------+
# | gameID | lengthGame | seriesID |
# +--------+------------+----------+
# |   8028 | 00:00:32   |        1 |
# +--------+------------+----------+

SELECT * From TeamCompetesInGame G where G.gameID = 8028
# +--------+--------+------+
# | teamID | gameID | won  |
# +--------+--------+------+
# | 1      |   8028 | won  |
# | 2      |   8028 | lost |
# +--------+--------+------+


# Part 3: I modified the DataGenerator to create 20,000 series, which means about 80,000 games, ~2 million teamcompetesGame,
# and 8 million playerCompetesInGame.

Select * from Games G where G.lengthGame > "00:00:20";

# output
# | 800712 | 00:00:24   |   199999 |
# | 800713 | 00:00:22   |   199999 |
# | 800714 | 00:00:25   |   200000 |
# | 800715 | 00:00:23   |   200000 |
# | 800717 | 00:00:38   |   200000 |
# | 800718 | 00:00:38   |   200000 |
# +--------+------------+----------+
# 641077 rows in set (0.17 sec)

SELECT P.name, count(*) from Players P
join PlayerCompetesInGame PCIG on P.playerID = PCIG.playerID
where PCIG.won = "Won"
group by P.playerID
order by count(*) desc limit 10;

# Output:
# +-------------+----------+
# | name        | count(*) |
# +-------------+----------+
# | cool_ign110 |    14617 |
# | cool_ign56  |    14617 |
# | cool_ign109 |    14617 |
# | cool_ign107 |    14617 |
# | cool_ign60  |    14617 |
# | cool_ign108 |    14617 |
# | cool_ign57  |    14617 |
# | cool_ign58  |    14617 |
# | cool_ign59  |    14617 |
# | cool_ign106 |    14617 |
# +-------------+----------+
# 10 rows in set (1.61 sec)

# Rebuilt database, creating an index on lengthGame and PlayerCompetesInGame.won


Select * from Games G where G.lengthGame > "00:00:20";
# | 800560 | 00:00:44   |   199960 |
# | 800593 | 00:00:44   |   199969 |
# | 800629 | 00:00:44   |   199977 |
# | 800682 | 00:00:44   |   199992 |
# | 800685 | 00:00:44   |   199993 |
# +--------+------------+----------+
# 641077 rows in set (0.17 sec)
# I honestly don't know why it didn't speed up AT ALL, if I EXPLAIN the query it shows it is using an index


SELECT P.name, count(*) from Players P
join PlayerCompetesInGame PCIG on P.playerID = PCIG.playerID
where PCIG.won = "Won"
group by P.playerID
order by count(*) desc limit 10;

# +-------------+----------+
# | name        | count(*) |
# +-------------+----------+
# | cool_ign110 |    14617 |
# | cool_ign56  |    14617 |
# | cool_ign109 |    14617 |
# | cool_ign107 |    14617 |
# | cool_ign60  |    14617 |
# | cool_ign108 |    14617 |
# | cool_ign57  |    14617 |
# | cool_ign58  |    14617 |
# | cool_ign59  |    14617 |
# | cool_ign106 |    14617 |
# +-------------+----------+
# 10 rows in set (0.85 sec)

# This one was cut in half