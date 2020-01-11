#Learning from: https://www.w3schools.com/python/python_variables.asp
#-------------------------------------------------------------------------
#Variables are containers for storing data values.
#Unlike other programming languages, Python has no command for declaring a variable.
#A variable is created the moment you first assign a value to it.
x = 5
y = "John"
print(x)
print(y)
print('\n')

#Variables do not need to be declared with any particular type
#and can even change type after they have been set.
x = 4       # x is a type of int
x = "Sally" # x is now of type str
print(x)
print('\n')

#double quotes are the same as single quotes:
x = "John"
print(x)
x = 'John'
print(x)
print('\n')

#+=
x = 1       # x is a int
x = x + 2   # x = x + 2 = 3
print(x)
x += 2      # x = x + 2 = 5
print(x)
print('\n')

#The variable names can contain -> (A-z, 0-9, and _ )
#But can't start with a number
#And they are case sensitive

#X (upper case) is dif than x (lower case)
X = 1
x = 20
print(x)
print(X)
print('\n')

#Assign Value to Multiple Variables in one line
x, y, z = "Orange", "Banana", "Cherry"
print(x)
print(y)
print(z)
print('\n')

#And you can assign the same value to multiple variables in one line
x = y = z = "Orange"
print(x)
print(y)
print(z)
print('\n')

#Output Variables
#The Python print statement is often used to output variables.
#To combine both text and a variable, Python uses the + character:
x = "awesome"
print("Python is " + x)
print('\n')
#You can also use the + character to add a variable to another variable:
x = "Python is "
y = "awesome"
z =  x + y
print(z)
print('\n')
#But cannot use it with 'int+str'
#Uncomment the 3 lines below and will give an error message
#x = 5
#y = "John"
#print(x + y)

#All the variables above are global, because neither of them
#are inside a function

#Here is x a global variable and p a local one
x = "awesome"

def myfunc():
    p = 'Python is '
    print(p + x)

myfunc()

#Now if I use x as a local name variable, the function will
#use de local instead the global one
x = "awesome"

def myfunc2():
    x = "superawesome"
    p = 'Python is '
    print(p + x)

myfunc2()
print(x) #the value of the global x wasn't changed

#To create a global variable inside a function, it can be used the keyword "global"
#before de variable name
def myfunc3():
    #global x = 'whatsup' #this isn't right
    global x
    x = 'whatsup'
    print(x)

myfunc3()
print(x) #the value of the global x was changed


