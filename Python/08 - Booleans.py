# Booleans
a = 200
b = 33

if b > a:
  print("b is greater than a")
else:
  print("b is not greater than a")

# bool() function
# Evaluate any value and return True of False
# Almost any value is evaluated to True if it has some sort of content.
# Any string is True, except empty strings.
# Any number is True, except 0.
# Any list, tuple, set, and dictionary are True, except empty ones.
print(bool("Hello"))    # True
print(bool(15))         # True
print(bool(""))         # False
print(bool(0))          # False
print(bool((0,0)))      # True
print(bool([0,0]))      # True
print(bool())           # False
print(bool(a))          # True
print()
# Every evaluation below will return False
print(bool(False))      # Bool False
print(bool(None))       # None value
print(bool(0))          # Number 0
print(bool(""))         # Empty string
print(bool(()))         # Empty tuple
print(bool([]))         # Empty list
print(bool({}))         # Empty set
print()

# One more value, or object in this case, evaluates to False,
# and that is if you have an objects that are made from a class
# with a __len__ function that returns 0 or False: 
class myclass():
  def __len__(self):
    return 0

myobj = myclass()
print(bool(myobj))
print()

# Python also has many built-in functions that returns a boolean value,
# like the isinstance() function, which can be used to determine if an
# object is of a certain data type.
x = 200
print(isinstance(x, int))
print(isinstance(x, float))
print(isinstance(float(x), float))