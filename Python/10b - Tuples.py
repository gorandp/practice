# Tuple

# A tuple is a collection which is ordered and unchangeable.
# In Python tuples are written with round brackets.
thistuple = ("apple", "banana", "cherry")

# Access tuple items
## The same way as lists
print(">>>> Access tuple items <<<<")
print("thistuple:\t", thistuple)
print("thistuple[1]:\t", thistuple[1])
print("thistuple[-1]:\t", thistuple[-1])
thistuple = ("apple", "banana", "cherry", "orange", "kiwi", "melon", "mango")
print("thistuple:\t", thistuple)
print("thistuple[2:5]:\t", thistuple[2:5]) #  The search will start at index 2 (included) and end at index 5 (not included)
print("thistuple[-4:-1]:", thistuple[-4:-1])
print()

# Change Tuple Values
## Simply, you can't. But, if you copy its content into a list
## edit the list and then create a tuple of that edited content
## replacing the original tuple, you can say you're "editing" it.
print(">>>> Change Tuple Values <<<<")
x = ("apple", "banana", "cherry")
print("x = ", x)
y = list(x)
y[1] = "kiwi"
x = tuple(y)
print("x = ", x, '\n')


# Loop Through a Tuple
print(">>>> Loop Through a Tuple <<<<")
print("x = ", x)
for item in x:
    print("item: ", item)
print()


# Check if an item exists
print(">>>> Check if an item exists <<<<")
if "apple" in thistuple:
    print("Yes, 'apple' is in \"thistuple\"")
else:
    print("No, 'apple' isn't in \"thistuple\"")
print()


# Tuple lenght
print(">>>> Tuple lenght <<<<")
print(len(thistuple), '\n') 


# Add Items
## Once a tuple is created, you cannot add items to it. Tuples are unchangeable.
print(">>>> Add items <<<<")
try:
    thistuple[3] = "orange" # This will raise an error
except:
    print("Error raised. Sentence no executed thistuple[3] = \"orange\"")
    print("It's true! W3Schools didn't lie to me.")
else:
    print("W3Schools lied to me T.T")
finally:
    print(thistuple, '\n')


# Create Tuple With One Item
## To create a tuple with only one item, you have add a comma 
## after the item, unless Python will not recognize the variable as
## a tuple.
print(">>>> Create Tuple With One Item <<<<")
thistuple = ("apple",)
print("thistuple = (\"apple\",)\t", type(thistuple))
#NOT a tuple
thistuple = ("apple")
print("thistuple = (\"apple\")\t", type(thistuple))
print()


# Remove Items
## You can't. But you can delete the whole tuple
print(">>>> Remove Items <<<<")
del thistuple
try:
    print(thistuple) #this will raise an error because the tuple no longer exists 
except:
    print("Exception raised. Couldn't print thistuple")
else:
    print("OMG, actually printed it?")
finally:
    print()


# Join Two Tuples
## To join two or more tuples you can use the + operator:
print(">>>> Join Two Tuples <<<<")
tuple1 = ("a", "b" , "c")
tuple2 = (1, 2, 3)
tuple3 = tuple1 + tuple2
print("tuple1 =", tuple1)
print("tuple2 =", tuple2)
print("tuple3 =", tuple3, '\n')


# The tuple() Constructor
## It is also possible to use the tuple() constructor to make a tuple.
print(">>>> The tuple() Constructor <<<<")
thistuple = tuple(("apple", "banana", "cherry")) # note the double round-brackets
print(thistuple)
