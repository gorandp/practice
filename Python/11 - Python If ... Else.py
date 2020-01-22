#a = 33
b = 200
a = 500

if b > a:
    print("b is greater than a")
elif b == a:
    print("b and a are equal")
else:
    print("a is greater than b")

# One statement
if a > b: print("a is greater than b")

# With else
print("A") if a > b else print("B")

# With two conditions
print("A") if a > b else print("=") if a == b else print("B")

# and operator
print(">>>> and operator <<<<")
a = 200
b = 33
c = 500
if a > b and c > a:
    print("Both conditions are True")
print()

# or operator
print(">>>> or operator <<<<")
a = 200
b = 33
c = 500
if a > b or a > c:
    print("At least one of the conditions is True")
print()

# nested if
 x = 41

if x > 10:
  print("Above ten,")
  if x > 20:
    print("and also above 20!")
  else:
    print("but not above 20.") 


# The pass Statement
# if statements cannot be empty, but if you for some reason
# have an if statement with no content, put in the pass
# statement to avoid getting an error.
a = 33
b = 200

if b > a:
  pass