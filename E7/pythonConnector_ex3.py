# first need to make sure connector is installed:
#  python3 -m pip install mysql-connector-python

import mysql.connector

# note:  look at at end of this file - mydb.commit() and mydb.close() -> do not forget
# MUST commit the changes!!!!  (if you did any inserts, deletes, updates, load data.... )

print ("Hello - starting createAndLoadSailorDB.py")

mydb = mysql.connector.connect(
  # user='testuser',
  user='testuser2',
  # passwd='testuser',
  passwd='thepassword',
  database='test9',
  host='127.0.0.1',
  allow_local_infile='1'
)





print(mydb)
myc = mydb.cursor() 

# We need to reset the variable that allows loading of local files 
myc.execute('set global local_infile = 1') 

myc.execute ("show databases") 
for x in myc:
	print(x) 

myc.execute ("use test9") 

# print out which tables are in test9
myc.execute ("show tables") 
for x in myc:
	print(x) 




print('\nOutput from select count(*) from sailors :') 
myc.execute("select count(*) from sailors ;")
for x in myc:
	print(x) 

print('\nOutput from select count(*) from boats :') 
myc.execute("select count(*) from boats ;")
for x in myc:
	print(x) 

print('\nOutput from select count(*) from reserve :') 
myc.execute("select count(*) from reserve ;")
for x in myc:
	print(x) 

print("\nBoats for which there are no reservations")
myc.execute("select * from Boats B where B.bid not in (select r.bid from reserve r) ;")
for x in myc:
	print(x) 

print("\nSailors who have made no reservations")
myc.execute("select * from Sailors S where S.sid not in (select r.sid from reserve r) ;")
for x in myc:
	print(x) 


print("\nSailors who have made a reservation for which thier rating is insufficient")
myc.execute("select S.sid, s.name, S.rating, B.bid, B.ratingNeeded, R.rdate from Sailors S, Reserve R, Boats B where S.sid = R.sid and R.bid = B.bid and S.rating < B.ratingNeeded ;") 
# myc.execute("select * from Sailors S where S.sid < 10 ;") 
for x in myc:
	print(x) 



# MUST commit the changes!!!!  (if you did any inserts, deletes, updates, load data.... )
mydb.commit()
mydb.close() 


