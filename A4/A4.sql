## Get all games that happened on May 12th, 2012
Select G.gameID from Games G
join Series S on G.seriesID = S.seriesID
where S.seriesDate = '2012-05-12';

# +--------+
# | gameID |
# +--------+
# |   1233 |
# |   1234 |
# |   1235 |
# |   1236 |
# |   1237 |
# +--------+


## Get players with top 10 most games won
SELECT P.name, count(*) from Players P
join PlayerCompetesInGame PCIG on P.playerID = PCIG.playerID
where PCIG.won = "Won"
group by P.playerID
order by count(*) desc limit 10;

# +--------------+----------+
# | name         | count(*) |
# +--------------+----------+
# | cool_ign2931 |       26 |
# | cool_ign821  |       26 |
# | cool_ign822  |       26 |
# | cool_ign2932 |       26 |
# | cool_ign2933 |       26 |
# | cool_ign825  |       26 |
# | cool_ign824  |       26 |
# | cool_ign2935 |       26 |
# | cool_ign2934 |       26 |
# | cool_ign823  |       26 |
# +--------------+----------+



# Get champions that 40 or more players have as their top
SELECT TT.top, count(*) from TopThree TT
group by top
having COUNT(*) > 40
order by count(*) desc;

# +----------+----------+
# | top      | count(*) |
# +----------+----------+
# | champ139 |       49 |
# | champ120 |       49 |
# | champ105 |       47 |
# | champ71  |       47 |
# | champ151 |       46 |
# | champ87  |       46 |
# | champ147 |       45 |
# | champ79  |       45 |
# | champ91  |       45 |
# | champ124 |       44 |
# | champ49  |       43 |
# | champ83  |       41 |
# | champ85  |       41 |
# | champ4   |       41 |
# | champ110 |       41 |
# | champ89  |       41 |
# | champ52  |       41 |
# | champ103 |       41 |
# | champ74  |       41 |
# | champ9   |       41 |
# +----------+----------+



## TODO make a procedure or the equivalent in a real scripting language to automate replacing players
## Adding a new player to team 1
insert into Players values (5041, "Amazing Bandit", 0, '2021-02-19', 1);

# LCS> insert into Players values (5041, "Amazing Bandit", 0, '2021-02-19', 1)
# [2021-02-19 02:55:38] 1 row affected in 6 ms



## Adding a team for 'no team', currently unemployed players
insert into Teams values (-1, "NO TEAM", 0, 0);

# LCS> insert into Teams values (-1, "NO TEAM", 0, 0)
# [2021-02-19 03:00:29] 1 row affected in 3 ms



# Firing player 1 from team 1, -1 = no team
update Players
set teamID = -1
where playerID = 1;

# LCS> update Players
#      set teamID = -1
#      where playerID = 1
# [2021-02-19 03:01:11] 1 row affected in 3 ms



# Team 42 got a new sponsorship and everyone gets a higher salary (I wish this was how it worked :c )
update Players
set salary = salary + 10000
where teamID = 42

# LCS> update Players
#      set salary = salary + 10000
#      where teamID = 42
# [2021-02-19 03:04:44] 5 rows affected in 5 ms



