# Lists

thislist = ["apple", "banana", "cherry"]
print(thislist)


# Access items

print(thislist[0]) # output: apple
print(thislist[1]) # output: banana

## Negative indexing

print(thislist[-1]) # output: cherry

## Range of Indexes

thislist = ["apple", "banana", "cherry", "orange", "kiwi", "melon", "mango"]

print(thislist[2:5]) # output: ["cherry", "orange", "kiwi"]
# Item in position 5 is NOT included

print(thislist[:4]) # output: ["apple", "banana", "cherry", "orange"]
print(thislist[2:]) # output: ["cherry", "orange", "kiwi", "melon", "mango"]
# Leaving place with a blank, use the begining or ending item respectively

print(thislist[-4:-1]) # output: ["orange", "kiwi", "melon"]
# Item with index -1 is NOT included


# Change item value

thislist = ["apple", "banana", "cherry"]
thislist[1] = "blackcurrant"
print(thislist) # output: ["apple", "blackcurrant", "cherry"]

# Loop through a list

for item in thislist:
    print(item)

# Check if an item exists

if "banana" in thislist:
    print("Yeah, 'banana' is in the fruits list")
elif "blackcurrant" in thislist:
    print("Nope, 'banana' isn't in the fruits list, but 'blackcurrant' is.") # This is the output in this example
else:
    print("Nope, 'banana' isn't in the fruits list, neither 'blackcurrant'!")

# List lenght

print(len(thislist)) # Output: 3

# Add item

## At the end

thislist.append("banana")
print(thislist)

## At an specified index

thislist.insert(0 ,"orange")
print(thislist)
print()

# Remove item

print("thislist.remove(\"melon\")")
try:
    thislist.remove("melon")
    print("NOOO, I'M NOT AN OUTPUT IF AN ERROR RAISES")
except:
    print("No melon found")
else:
    print("Eating melon. . . \nDone")
finally:
    print("List: ", thislist)
    print()

print("thislist.pop() and thislist.pop(0)")
thislist.pop() # Deletes last item
thislist.pop(0) # Deletes first item
print("List: ", thislist)
print()

del thislist[0] # Deletes first item
print("del thislist[0]: ", thislist)
print()

print("del thislist")
del thislist
try:
    print("List: ", thislist)
except:
    print("Exception raised trying to display thislist")
finally:
    print()

thislist = ['orange', 'apple', 'blackcurrant', 'cherry', 'banana']

print("thislist.clear()")
thislist.clear()
print("List: ", thislist)
print()

# Copy a list

# You cannot copy a list simply by typing list2 = list1,
# because: list2 will only be a reference to list1,
# and changes made in list1 will automatically also be made
# in list2.

print("myOtherList = thislist")
thislist = ['orange', 'apple', 'blackcurrant', 'cherry', 'banana']
myOtherList = thislist
print("thislist.clear()")
thislist.clear()
#del thislist # Using this statement, we won't notice difference
              # This is due to myOtherList, because it is referencing
              # that place in memory, and so the garbage collector don't
              # delete its content. So, 
              # myOtherList = thislist
              # cause that both of the variable point to the same place
              # in memory.
try:
    print("List: ", myOtherList)
except:
    print("Exception raised trying to display myOtherList")
finally:
    print()

print("myOtherList = thislist.copy()")
thislist = ['orange', 'apple', 'blackcurrant', 'cherry', 'banana']
myOtherList = thislist.copy() # <<< copy method >>>
# also works
# myOtherList = list(thislist)
print("thislist.clear()")
thislist.clear()
try:
    print("List: ", myOtherList)
except:
    print("Exception raised trying to display myOtherList")
finally:
    print()


# Join two lists

thislist = list(myOtherList)
myOtherList.pop() # Deletes last item of myOtherList
thislist.pop(0) # Deletes first item of thislist
print("thislist: ", thislist)
print("myOtherList: ", myOtherList)
duplicatedList = thislist + myOtherList
print("duplicatedList: ", duplicatedList)
print()
thislist.clear()
myOtherList.clear()
print("[thislist and myOtherList cleared]\nduplicatedList: ", duplicatedList)
print()

print("append() method")
for x in duplicatedList:
    if x == "apple" or x == "banana" or x == "cherry":
        thislist.append(x)
    else:
        myOtherList.append(x)
print("thislist: ", thislist)
print("myOtherList: ", myOtherList)
print("duplicatedList: ", duplicatedList)
print()

print("extend() method | \"thislist.extend(myOtherList)\"")
thislist.extend(myOtherList)
print("thislist: ", thislist)
thislist.sort()
duplicatedList.sort()
print("thislist(sorted):\t", thislist)
print("duplicatedList(sorted):\t", duplicatedList)
print()

# list() constructor
print("list() constructor")
myOtherList = list(("apple", "banana", "cherry"))
print("myOtherList:\t", myOtherList)
