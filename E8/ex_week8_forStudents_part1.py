# first need to make sure connector is installed:
#  python3 -m pip install mysql-connector-python

# this assumes you have created a user named "testuser2" with all privileges:
#     mysql> create user 'testuser5'@'localhost' identified by 'thepassword' ;

#     mysql> grant all privileges on *.* to 'testuser5'@'localhost' ;
# to read more about how to create users:
#  https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql

import mysql.connector
import numpy as np

# note:  look at at end of this file - mydb.commit() and mydb.close() -> do not forget
# must commit the changes!!!!  (if you did any inserts, deletes, updates, load data.... )

print ("hello - starting pythonconnector_ex2.py")

mydb = mysql.connector.connect(
  user='testuser5',    # could be root, or a user you created, i created 'testuser2'
  passwd='thepassword',  # the password for that use
  database='test9',   # the database to connect to
  host='127.0.0.1',   # localhost
  allow_local_infile='1'  # needed so can load local files
)



print(mydb)
myc = mydb.cursor()   # myc name short for "my cursor"

# we need to reset the variable that allows loading of local files
myc.execute('set global local_infile = 1')

myc.execute ("show databases")  # this returns a list in myc that you can iterate over
for x in myc:
	print(x)

myc.execute ("use test9")

# print out which tables are in test9
myc.execute ("show tables")
for x in myc:
	print(x)


myc.execute("drop table if exists reserve ;")
myc.execute("drop table if exists sailors ;")
myc.execute("drop table if exists boats ;")

# multi-line python comment is three double quotes
myc.execute("""    
create table sailors ( 
  sid int, 
  name varchar(20) not null, 
  age int, 
  rating float not null, 
  primary key (sid) ) ; 
""")


myc.execute("""
create table boats (
  bid int,
  name varchar(20),
  ratingneeded int,
  bcolor varchar(20),
  primary key (bid) ) ;
""")

myc.execute("""
create table reserve (
  sid int, 
  bid int,
  rdate date,
  primary key (bid,sid,rdate),
  foreign key (bid) references boats(bid),
  foreign key (sid) references sailors(sid) ) ;
""")


print("\nbefore loading sailors:  select * from sailors where sid < 10")
myc.execute ("select * from sailors where sid < 10") ;
for x in myc:
	print(x)



colors = []
colors.append('red')
colors.append('green')
colors.append('blue')
colors.append('yellow')
colors.append('orange')
colors.append('purple')
colors.append('grey')
colors.append('brown')
colors.append('gold')
colors.append('silver')
colors.append('pink')
colors.append('moss')
colors.append('perwinkle')
colors.append('pumpkin')
colors.append('black')
colors.append('citron')
colors.append('coffee')
colors.append('chocolate')
colors.append('olive')
colors.append('peach')
colors.append('burnt umber')
colors.append('salmon')
colors.append('teal')
colors.append('vermilion')
colors.append('white')
colors.append('ivory')
colors.append('grape')
colors.append('lemon')
colors.append('lime')

numsailors = 100
numboats = 50
numreserve = 1000

for i in range(1,numsailors+1):
	anid = str(i)
	aname = 'sue' + str(i)
	anage = str(np.random.randint(80) + 18)
	arating = str( np.random.randint(10) + 1)
	astatement = 'insert into sailors values(' + anid + ',\'' + aname + '\',' + anage + ',' + arating + ');'
	print(astatement)
	myc.execute(astatement)

for i in range(1,numboats+1):
	abid = str(i)
	abname = 'shark' + str(i)
	aratingneeded = str(np.random.randint(10) + 1)
	abcolor = colors[ np.random.randint( len(colors) ) ]
	astatement = 'insert into boats values(' + abid + ',\'' + abname + '\',' + aratingneeded + ',\'' + abcolor + '\');'
	print(astatement)
	myc.execute(astatement)

for i in range(1,numreserve+1):
	sid = str( np.random.randint(numsailors) + 1)
	bid = str( np.random.randint(numboats) + 1)
	adate = '2020-' + str(np.random.randint(12)+1)
	adate += '-' + str(np.random.randint(28)+1)
	astatement = 'insert into reserve values(' + sid + ',' + bid + ',' + '\'' +  adate + '\');'
	print(astatement)
	try:
		myc.execute(astatement)
	except:
		print("there was an error, hopefully continuing on....")


print('\noutput from select count(*) from sailors :')
myc.execute("select count(*) from sailors ;")
for x in myc:
	print(x)

print('\noutput from select count(*) from boats :')
myc.execute("select count(*) from boats ;")
for x in myc:
	print(x)

print('\noutput from select count(*) from reserve :')
myc.execute("select count(*) from reserve ;")
for x in myc:
	print(x)

print("\nboats that are blue")
myc.execute("select * from boats b where b.bcolor =  'blue'") ;
for x in myc:
	print(x)

print("\nsailor that have reserved a blue boat:")
myc.execute("select distinct s.sid, s.name from boats b, sailors s, reserve r where s.sid = r.sid and r.bid = b.bid and b.bcolor =  'blue' order by s.sid ;")
for x in myc:
	print(x)

myc.execute("delete from reserve where bid in (select b.bid from boats b where  b.bcolor =  'blue') ;")

print("\nafter the delete of blue boat reservations, sailors that have reserved a blue boat:")
myc.execute("select distinct s.sid, s.name from boats b, sailors s, reserve r where s.sid = r.sid and r.bid = b.bid and b.bcolor =  'blue' order by s.sid ;")
for x in myc:
	print(x)



# must commit the changes!!!!  (if you did any inserts, deletes, updates, load data.... )
mydb.commit()
mydb.close()


