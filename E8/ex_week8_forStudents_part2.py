# first need to make sure connector is installed:
#  python3 -m pip install mysql-connector-python

# this assumes you have created a user named "testuser2" with all privileges:
#     mysql> create user 'testuser2'@'localhost' identified by 'thepassword' ;
#     mysql> grant all privileges on *.* to 'testuser2'@'localhost' ;
# to read more about how to create users: 
#  https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql


import mysql.connector
import numpy as np

# note:  look at at end of this file - mydb.commit() and mydb.close() -> do not forget
# MUST commit the changes!!!!  (if you did any inserts, deletes, updates, load data.... )

print("Hello - starting pythonConnector_ex2.py")

mydb = mysql.connector.connect(
    user='testuser5',  # could be root, or a user you created, I created 'testuser2'
    passwd='thepassword',  # the password for that use
    database='test9',  # the database to connect to
    host='127.0.0.1',  # localhost
    allow_local_infile='1'  # needed so can load local files
)

myc = mydb.cursor(buffered=True)  # myc name short for "my cursor"

# We need to reset the variable that allows loading of local files 
myc.execute('set global local_infile = 1')

theCommand = 'select * from reserve R join sailors S on S.sid = R.sid ;'
myc.execute(theCommand)
theRows = myc.fetchall()  # gets all rows
for aRow in theRows:
    if (aRow[5] >= 20):

        sid = aRow[0]
        newCommand = "delete from reserve where sid = " + str(aRow[0]) + " ;"
        print(newCommand)
        myc.execute(newCommand)

# Output:
# ...
# delete from reserve where sid = 99 ;
# delete from reserve where sid = 99 ;
# delete from reserve where sid = 99 ;
# delete from reserve where sid = 99 ;
# delete from reserve where sid = 99 ;
# delete from reserve where sid = 99 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;
# delete from reserve where sid = 100 ;


# select * from sailors S where S.sid = 100
# +-----+--------+------+--------+
# | sid | name   | age  | rating |
# +-----+--------+------+--------+
# | 100 | sue100 |   50 |      7 |
# +-----+--------+------+--------+
# I know this isn't definitive proof but its a sample ¯\_(ツ)_/¯


# MUST commit the changes!!!!  (if you did any inserts, deletes, updates, load data.... )
mydb.commit()
mydb.close()
