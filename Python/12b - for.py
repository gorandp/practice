# for loop
fruits = ["apple", "banana", "cherry"]
for x in fruits:
    print(x)

# for loop in strings
for x in "banana":
    print(x)

# break statement
print(">>>> break statement <<<<")
fruits = ["apple", "banana", "cherry"]
for x in fruits:
    print(x)
    if x == "banana":
        break
print()

# continue statement
print(">>>> continue statement <<<<")
fruits = ["apple", "banana", "cherry"]
for x in fruits:
    if x == "banana":
        continue
    print(x)
print()

# range() function
print(">>>> range() function <<<<")
print("-- for x in range(6): #sequence of numbers from 0 to 5")
for x in range(6):
    print(x)
print()
# Note that range(6) is not the values of 0 to 6, but the values 0 to 5.
print("-- for x in range(2, 6): #start parameter is 2")
for x in range(2, 6):
    print(x)
print("-- for x in range(2, 30, 3): #increments by 3")
for x in range(2, 30, 3):
    print(x)
print()

# else statment
print(">>>> else statement <<<<")
for x in range(6):
    print(x)
else:
    print("Finally finished!") 
print()

# nested for
print(">>>> nested for <<<<")
adj = ["red", "big", "tasty"]
fruits = ["apple", "banana", "cherry"]
for x in adj:
  for y in fruits:
    print(x, y) 
print()

# pass statement
print(">>>> pass statement <<<<")
for x in [0, 1, 2]:
    pass
