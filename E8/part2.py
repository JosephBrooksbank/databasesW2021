import pymongo

my_client = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = my_client["e8"]
collection = mydb["part2"]

first_user = {"sid": 1, "name": "Sue", "age": 22, "rating": 7}
second_user = {"sid": 2, "name": "Mary", "age": 25, "rating": 5}

collection.insert_one(first_user)
collection.insert_one(second_user)
for x in collection.find():
    print(x)