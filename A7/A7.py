# 1 DESCRIPTION OF PROBLEM:
# MySQL scripting was not sufficient to handle adding a game, namely adding the game to the Players' history
# on account of not being able to handle variables with multiple rows stored. I have rebuilt add_game in python
# which now correctly handles adding the Game, adding the game to TeamCompetesInGame, and adding the game to
# all of the Players' PlayerCompetesInGame. There is also a small client that asks for user input and makes sure '
# it is valid before running queries.


import mysql.connector


class DatabaseCommands:

    def at_exit(self):
        self.mydb.commit()
        self.mydb.close()

    def __init__(self):
        self.mydb = mysql.connector.connect(
            user='testuser5',
            passwd='thepassword',
            database='LCS',
            host='127.0.0.1',
            allow_local_infile='0'
        )
        self.myc = self.mydb.cursor(buffered=True)

    def find_teams_in_series(self, seriesID):
        try:
            self.myc.execute('SELECT TS.teamID from TeamCompetesInSeries TS WHERE TS.seriesID = ' + str(seriesID))
            teams = self.myc.fetchall()
            return {"team1": int(teams[0][0]),
                   "team2": int(teams[1][0])
                    }
        except IndexError:
            return None

    # Continuation of the last assignment, properly adds a game to a series and updates all players and teams involved.
    def add_game(self, game):
        # type: (Game) -> None
        self.myc.execute('SELECT MAX(G.gameID) from Games G')
        game_id = self.myc.fetchone()
        game_id = int(game_id[0])
        game_id += 1

        self.myc.execute('SELECT TS.teamID from TeamCompetesInSeries TS WHERE TS.seriesID = ' + str(game.seriesID))

        teams = self.myc.fetchall()

        team1 = int(teams[0][0])
        team2 = int(teams[1][0])

        self.myc.execute('SELECT P.playerID from Players P where P.teamID = ' + str(team1))
        team1_players = self.myc.fetchall()

        self.myc.execute('SELECT P.playerID from Players P where P.teamID = ' + str(team2))
        team2_players = self.myc.fetchall()

        self.myc.execute('INSERT INTO Games (gameID, lengthGame, seriesID) VALUES (%s, %s, %s)',
                         (game_id, game.length, game.seriesID))

        if game.won == team1:
            self.myc.execute \
                ('INSERT INTO TeamCompetesInGame (teamID, gameID, won) VALUES ({}, {}, "won")'.format(team1, game_id))
            self.myc.execute \
                ('INSERT INTO TeamCompetesInGame (teamID, gameID, won) VALUES ({}, {}, "lost")'.format(team2, game_id))
            for player in team1_players:
                self.myc.execute \
                    ('INSERT INTO PlayerCompetesInGame (playerID, gameID, won) VALUES ({}, {}, "won")'.format(player[0],
                                                                                                              game_id))
            for player in team2_players:
                self.myc.execute \
                        ('INSERT INTO PlayerCompetesInGame (playerID, gameID, won) VALUES ({}, {}, "lost")'.format(
                        player[0],
                        game_id))

        elif game.won == team2:
            self.myc.execute \
                ('INSERT INTO TeamCompetesInGame (teamID, gameID, won) VALUES ({}, {}, "won")'.format(team2, game_id))
            self.myc.execute \
                ('INSERT INTO TeamCompetesInGame (teamID, gameID, won) VALUES ({}, {}, "lost")'.format(team1, game_id))
            for player in team2_players:
                self.myc.execute \
                    ('INSERT INTO PlayerCompetesInGame (playerID, gameID, won) VALUES ({}, {}, "won")'.format(player[0],
                                                                                                              game_id))
            for player in team1_players:
                self.myc.execute \
                        ('INSERT INTO PlayerCompetesInGame (playerID, gameID, won) VALUES ({}, {}, "lost")'.format(
                        player[0],
                        game_id))
        else:
            print("Winning team not one of teams participating in series")


class Game:
    def __init__(self, seriesID, length, won):
        self.seriesID = seriesID
        self.length = length

        self.won = won

# Simple 'client' to handle input of games by user
def main():
    db_command = DatabaseCommands()
    print("Simple client to add a game:")
    while True:
        seriesID = input("What is the seriesID which this game was part of?\n")
        teams = db_command.find_teams_in_series(seriesID)
        if teams:
            print("Teams involved are: " + str(teams.get("team1")) + ", " + str(teams.get("team2")) + ".")
            break
        else:
            print("Not a recognized series.\n")
    won = int(input("Who won? Enter ID\n"))
    length = input("How long was the game? Enter in minutes\n")
    length = "00:00:" + str(length)
    game = Game(seriesID, length, won)

    db_command.add_game(game)
    db_command.at_exit()


if __name__ == '__main__':
    main()


# 3: Output
# Before:
# select * from Games where gameID = (Select MAX(gameID) from Games);
# +--------+------------+----------+
# | gameID | lengthGame | seriesID |
# +--------+------------+----------+
# | 800723 | 00:00:37   |        1 |
# +--------+------------+----------+

# After running, with input of 14, 21, 32:
# +--------+------------+----------+
# | gameID | lengthGame | seriesID |
# +--------+------------+----------+
# | 800724 | 00:00:32   |       14 |
# +--------+------------+----------+
