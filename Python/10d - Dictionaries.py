thisdict =	{
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}

def rdict():
    global thisdict
    thisdict =	{
    "brand": "Ford",
    "model": "Mustang",
    "year": 1964
    }

def pdict():
    print("this dict: ", thisdict)


# Accessing Items
print(">>>> Accessing Items <<<<")
pdict()
print("-- thisdict['model'] thisdict.get('model')")
x = thisdict["model"]
print(x)
x = thisdict.get("model")
print(x)
print()


# Change Values
print(">>>> Change Values <<<<")
pdict()
print("-- thisdict['year'] = 2018")
thisdict["year"] = 2018
pdict()
print()


# Loop Through a Dictionary
print(">>>> Loop Through a Dictionary <<<<")
rdict()
pdict()
print("-- for <key> in <dictionaryName>, print(key)")
for key in thisdict:
    print(key)
print("-- for <key> in <dictionaryName>, print(<dictionaryName>[key])")
for key in thisdict:
    print(thisdict[key])
print("-- for <value> in <dictionaryName>.values(), print(value)")
for value in thisdict.values():
    print(value)
print()


# Check if Key Exists
print(">>>> Check if Key Exists <<<<")
pdict()
print("-- 'model' in thisdict")
if "model" in thisdict:
  print("Yes, 'model' is one of the keys in the thisdict dictionary") 
print("-- 'Mustang' in thisdict.values()")
if 'Mustang' in thisdict.values():
  print("Yes, 'Mustang' is one of the values in the thisdict dictionary") 
print()


# Dictionary Length
print(">>>> Dictionary Length <<<<")
pdict()
print("-- print(len(thisdict))")
print(len(thisdict))
print()


# Adding Items
print(">>>> Adding Items <<<<")
pdict()
print("-- <dictionary>[<newKey>] = <newValue>, ex. thisdict[\"color\"] = \"red\"")
thisdict["color"] = "red"
pdict()
print()


# Removing Items
print(">>>> Removing Items <<<<")
rdict()
pdict()
print("-- pop('model') method")
thisdict.pop('model')
pdict()
print("-- popitem('model') method (in versions before 3.7, a random item is removed instead)")
rdict()
thisdict.popitem()
pdict()
print("-- del thisdict[\"model\"]")
rdict()
del thisdict["model"]
pdict()
print("-- del thisdict")
del thisdict
try:
    pdict()
except:
    print("Error raised. Can't print thisdict.")
print("-- clear() method")
thisdict = {}
rdict()
thisdict.clear()
pdict()
print()


# Copy a Dictionary
print(">>>> Copy a Dictionary <<<<")
# You cannot copy a Dictionary simply by typing dict2 = dict1,
# because: dict2 will only be a reference to dict1,
# and changes made in dict1 will automatically also be made
# in dict2.
print("-- myOtherdict = thisdict [X-DOESN'T WORK-X]")
rdict()
myOtherdict = thisdict
print("thisdict.clear()")
thisdict.clear()
#del thisdict # Using this statement, we won't notice difference
              # This is due to myOtherdict, because it is referencing
              # that place in memory, and so the garbage collector don't
              # delete its content. So, 
              # myOtherdict = thisdict
              # cause that both of the variable point to the same place
              # in memory.
try:
    print("myOtherdict: ", myOtherdict)
except:
    print("Exception raised trying to display myOtherdict")

print("-- copy() method, myOtherdict = thisdict.copy()")
rdict()
myOtherdict = thisdict.copy() # <<< copy method >>>
print("thisdict.clear()")
thisdict.clear()
try:
    print("dict: ", myOtherdict)
except:
    print("Exception raised trying to display myOtherdict")

print("-- dict() method, myOtherdict = dict(thisdict)")
rdict()
myOtherdict.clear()
del myOtherdict
myOtherdict = dict(thisdict)
print()


# Nested Dictionaries
print(">>>> Nested Dictionaries <<<<")
myfamily = {
  "child1" : {
    "name" : "Emil",
    "year" : 2004
  },
  "child2" : {
    "name" : "Tobias",
    "year" : 2007
  },
  "child3" : {
    "name" : "Linus",
    "year" : 2011
  }
}
print(myfamily)
# or
child1 = {
  "name" : "Emil",
  "year" : 2004
}
child2 = {
  "name" : "Tobias",
  "year" : 2007
}
child3 = {
  "name" : "Linus",
  "year" : 2011
}

myfamily = {
  "child1" : child1,
  "child2" : child2,
  "child3" : child3
}
print(myfamily)
print()


# The dict() Constructor
print(">>>> The dict() Constructor <<<<")
print("-- thisdict = dict(brand=\"Ford\", model=\"Mustang\", year=1964)")
thisdict = dict(brand="Ford", model="Mustang", year=1964)
# note that keywords are not string literals
# note the use of equals rather than colon for the assignment
print(thisdict)
