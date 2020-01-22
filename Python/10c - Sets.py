thisset = {}

def beepBoop():
    global thisset
    thisset = {"apple", "banana", "cherry", "orange"}

def printSet():
    print("thisset: ", thisset)

# Access items (unordered)(no index)
print(">>>> Access items <<<<")
beepBoop()
printSet()
print("-- for <item> in <setName> statement output:")
for x in thisset:
    print(x)
print("-- \"banana\" in <setName> check output:")
print("banana" in thisset)
print()


# Add items (cant change them once created, but can be deleted)
print(">>>> Add items <<<<")
beepBoop()
printSet()
print("-- add(\"strawberry\") method")
thisset.add("strawberry")
printSet()
print("-- update(['strawberry','melon']) method")
beepBoop()
thisset.update(['strawberry','melon'])
printSet()
print()


# Lenght method
print(">>>> Lenght of a set <<<<")
beepBoop()
printSet()
print("-- print(len(thisset)) or print(thisset.__len__())")
print(len(thisset))
print(thisset.__len__())
print()


# Remove item
print(">>>> Remove item <<<<")
printSet()
print("-- remove('banana') method")
thisset.remove('banana')
printSet()
print("-- remove('strawberry') method raising error")
beepBoop()
try:
    thisset.remove('strawberry')
except:
    print("Error raised. Item not found")
else:
    print("Item deleted succesfully")
finally:
    printSet()
print("-- discard('banana') method")
beepBoop()
thisset.discard('banana')
printSet()
print("-- discard('strawberry') method not raising error when item not found")
beepBoop()
thisset.discard('strawberry')
printSet()
print("-- pop() method delete last item (but don't know which one is the last one)")
beepBoop()
x = thisset.pop()
printSet()
print("Item deleted: ", x)
print("-- clear() method")
beepBoop()
thisset.clear()
printSet()
print("-- del <nameSet>")
beepBoop()
del thisset
try:
    printSet()
except:
    print("Can't print set. It doesn't exist.")
print()


# Join sets
set1 = {"apple", "banana", "cherry", "orange"}
set2 = {"apple", "banana", "strawberry", "melon"}
print(">>>> Join sets <<<<")
print("set1: ", set1)
print("set2: ", set2)
print("-- set3 = set1.union(set2) method [will exclude any duplicate items]")
set3 = set1.union(set2)
print("set3: ", set3)
print("-- set1.update(set2) method [will exclude any duplicate items]")
set1.update(set2)
print("set1: ", set1)


# set() constructor
print(">>>> set() constructor <<<<")
thisset = set(("apple", "banana", "cherry")) # note the double round-brackets
printSet()



