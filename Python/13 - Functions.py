# Creating a Function
def my_function():
    print("Hello from a function")


# Calling a function
my_function()


#Arguments
def my_function(fname):
  print(fname + " Refsnes")

my_function("Emil")
my_function("Tobias")
my_function("Linus")


# If we execute
# my_function("Emil", "Tobias") 
# we'll get an error.
# Also with
# my_function()


# Arbitrary Arguments, *args
def my_function(*kids):
  print("The youngest child is " + kids[2])

my_function("Emil", "Tobias", "Linus")
print()
# Tuple as argument


# Keyword Arguments
## You can also send arguments with the key = value syntax.
## This way the order of the arguments does not matter.
def my_function(child3, child2, child1):
  print("The youngest child is " + child3)

my_function(child1 = "Emil", child2 = "Tobias", child3 = "Linus")
print()
# The phrase Keyword Arguments are often shortened to kwargs in Python documentations.


# Arbitrary Keyword Arguments, **kwargs
## If you do not know how many keyword arguments that will be passed into your function, 
## add two asterix: ** before the parameter name in the function definition.
#
## This way the function will receive a dictionary of arguments, and can access the items 
## accordingly.
def my_function(**kid):
  print("His last name is " + kid["lname"])

my_function(fname = "Tobias", lname = "Refsnes")
print()




