import numpy as np
from datetime import timedelta, datetime
from random import randrange

np.random.seed(1)

teams = []
teams.append("Cloud9")
teams.append("Dignitas")
teams.append("Evil Geniuses")
teams.append("100 Thieves")
teams.append("FlyQuest")
teams.append("TSM")
teams.append("Golden Guardians")
teams.append("Immortals")
teams.append("Team Liquid")
teams.append("Counter Logic Gaming")

# generating more teams for more data
for i in range(1, 100):
    original_team = teams[np.random.randint(10) + 1]
    teams.append(original_team + str(i))


# generate a random day, for start days / game days
def random_date():
    d1 = datetime.strptime('10/27/2009', '%m/%d/%Y')
    d2 = datetime.today()
    delta = d2 - d1
    return (d1 + timedelta(days=randrange(delta.days))).date()


class Series:
    def __init__(self, seriesID, team1Won, team2Won, date, team1, team2):
        self.score = str(team1Won) + "-" + str(team2Won)
        self.team1Won = team1Won
        self.team2Won = team2Won
        self.won = team1 if team1Won > team2Won else team2
        self.date = date
        self.seriesID = seriesID
        self.team1 = team1
        self.team2 = team2


class Game:
    def __init__(self, gameID, length, seriesID, team1, team2, won):
        self.gameID = gameID
        self.length = length
        self.seriesID = seriesID
        self.team1 = team1
        self.team2 = team2
        self.won = won

class Player:
    def __init__(self, playerID, name, salary, startDate, teamID):
        self.playerID = playerID
        self.name = name
        self.salary =salary
        self.startDate = startDate
        self.teamID = teamID

games = []


def generateGame(numGames, seriesID, team1, team2, won):
    for x in range(0, numGames):
        length = "00:00:" + str(np.random.randint(30) + 15)
        games.append(Game(len(games) + 1, length, seriesID, team1, team2, won))


numSeries = 200001
series = []
for i in range(1, numSeries):
    team1 = teams[np.random.randint(len(teams))]
    team2 = teams[np.random.randint(len(teams))]
    gamesWon = np.random.randint(4)
    gamesLost = 3 if gamesWon < 3 else np.random.randint(3)
    generateGame(gamesLost, i, team1, team2, team2)
    generateGame(gamesWon, i, team1, team2, team1)
    date = random_date()
    series.append(Series(i, gamesWon, gamesLost, date, team1, team2))

players = []
for i in range(1,len(teams)):
    for x in range(0, 5):
        salary = str(np.random.randint(100000) + 1)  # how much money they make
        start = str(random_date())
        playerID = len(players) + 1
        name = 'cool_ign' + str(playerID)
        players.append(Player(playerID, name, salary, start, i))


champs = []
numChamps = 154
for i in range(1, 154):
    champs.append("champ" + str(i))

# create the Teams info
outfile = open("data_teams", "w")
for i in range(1, len(teams)):
    outString = ''
    outString += str(i)  # id
    outString += ','
    outString += teams[i]  # team name
    outString += ','
    seriesWon = (np.random.randint(10) + 1)  # number of series won
    seriesLost = (np.random.randint(10) + 1)  # number of series lost
    outString += str(seriesWon)
    outString += ","
    outString += str(seriesLost)
    outString += "\n"
    outfile.write(outString)
outfile.close()

# create the player data
numPlayers = 5 * len(teams)
outfile = open("data_player", "w")
for i in players:
    outString = ''
    outString += str(i.playerID)
    outString += ','
    outString += i.name
    outString += ','
    outString += i.salary
    outString += ','
    outString += i.startDate
    outString += ','
    outString += str(i.teamID)
    outString += "\n"
    outfile.write(outString)
outfile.close()

# create the coach data
numCoaches = len(teams)
outfile = open("data_coach", "w")
for i in range(1, numCoaches):
    outString = ''
    outString += str(i)  # coachID
    outString += ','
    outString += 'professional_name'
    outString += str(i)  # coach differentiator
    outString += ','
    salary = str(np.random.randint(100000) + 1)  # how much money they make
    outString += salary
    outString += ','
    outString += str(random_date())
    outString += ','
    outString += str(i)
    outString += "\n"
    outfile.write(outString)
outfile.close()

# Creating Series file
outfile = open("data_series", "w")
for i in series:
    outString = ''
    outString += str(i.seriesID)
    outString += ','
    outString += str(i.date)
    outString += ','
    outString += i.score
    outString += '\n'
    outfile.write(outString)
outfile.close()

# creating Games file
outfile = open("data_games", "w")
for i in games:
    outString = ''
    outString += str(i.gameID)
    outString += ','
    outString += i.length
    outString += ','
    outString += str(i.seriesID)
    outString += '\n'
    outfile.write(outString)
outfile.close()

outfile = open("data_playerInSeries", "w")
for i in series:
    for x in players:
        if i.team1 == teams[x.teamID] or i.team2 == teams[x.teamID]:
            outString = ''
            outString += str(x.playerID)
            outString += ','
            outString += str(i.seriesID)
            outString += ','
            won = i.team1Won > i.team2Won
            # kind of messy; if the team matched is the first team and the first team won, then the player won.
            # if the first team didn't win, then the player lost. Same but in reverse for if the player was on team2.
            if i.team1 == teams[x.teamID]:
                if won:
                    wonString = "Won"
                else:
                    wonString = "Lost"
            else:
                if won:
                    wonString = "Lost"
                else:
                    wonString = "Won"
            outString += wonString
            outString += '\n'
            outfile.write(outString)
outfile.close()


# SUPER inefficient ¯\_(ツ)_/¯
outfile = open("data_playerInGame", "w")
for i in games:
    for x in players:
        playerTeam = teams[x.teamID]
        if i.team1 == playerTeam or i.team2 == playerTeam:
            outString = ''
            outString += str(x.playerID)
            outString += ','
            outString += str(i.gameID)
            outString += ','
            # kind of messy; if the team matched is the first team and the first team won, then the player won.
            # if the first team didn't win, then the player lost. Same but in reverse for if the player was on team2.
            if i.team1 == playerTeam:
                if i.won == i.team1:
                    wonString = "Won"
                else:
                    wonString = "Lost"
            else:
                if i.won == i.team1:
                    wonString = "Lost"
                else:
                    wonString = "Won"
            outString += wonString
            outString += '\n'
            outfile.write(outString)
outfile.close()

outfile = open("data_teamInSeries", "w")
for i in series:
    outString = ''
    outString += str(teams.index(i.team1))
    outString += ','
    outString += str(i.seriesID)
    outString += ','
    outString += "Won" if i.won == i.team1 else "Lost"
    outString += '\n'
    outfile.write(outString)

    outString = ''
    outString += str(teams.index(i.team2))
    outString += ','
    outString += str(i.seriesID)
    outString += ','
    outString += "won" if i.won == i.team2 else "lost"
    outString += '\n'
    outfile.write(outString)
outfile.close()

outfile = open("data_teamInGame", "w")
for i in games:
    outString = ''
    outString += str(teams.index(i.team1))
    outString += ','
    outString += str(i.gameID)
    outString += ','
    outString += "Won" if i.won == i.team1 else "Lost"
    outString += '\n'
    outfile.write(outString)

    outString = ''
    outString += str(teams.index(i.team2))
    outString += ','
    outString += str(i.gameID)
    outString += ','
    outString += "won" if i.won == i.team2 else "lost"
    outString += '\n'
    outfile.write(outString)
outfile.close()

outfile = open("data_favChamps", "w")
for i in players:
    outString = ''
    outString += str(i.playerID)
    outString += ','
    index = np.random.randint(numChamps - 4) + 1
    outString += champs[index]
    index+=1
    outString += ','
    outString += champs[index]
    index +=1
    outString += ','
    outString += champs[index]
    outString += '\n'
    outfile.write(outString)
outfile.close()

