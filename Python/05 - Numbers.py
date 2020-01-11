#There are 3 types of number in python
x = 1    # int
y = 2.8  # float
z = 1j   # complex

print(type(x))
print(type(y))
print(type(z))
print()

# Int
# Whole number
# Positive or negative
# No decimals
# Unlimited length
x = 1
y = 35656222554887711
z = -3255522

print(type(x))
print(type(y))
print(type(z))
print()

#Float
# "floating point number"
# is a number, positive or negative
# contain one or more decimals
x = 1.10
y = 1.0
z = -35.59

print(type(x))
print(type(y))
print(type(z))

# can also be scientific numbers with an "e" to indicate the power of 10
x = 35e3
y = 12E4
z = -87.7e100

print(type(x))
print(type(y))
print(type(z))
print()

# Complex
# Imaginary part written with a "j"
x = 3+5j
y = 5j
z = -5j
d = 5.5 - 19.2j

print(type(x))
print(type(y))
print(type(z))
print(d)
print(type(d))
print()

# Type Conversion
# You can convert from one type to another, except complex
# you can't convert from a complex number to another type of number
x = 1 # int
y = 2.8 # float
z = 1j # complex

# convert from int to float:
a = float(x)

# convert from float to int:
b = int(y)

# convert from int to complex:
c = complex(x)

print(a)
print(b)
print(c)

print(type(a))
print(type(b))
print(type(c))
print()

# Random
# Python does not have a random() function to make a random number,
# but Python has a built-in module called random that can be used to
# make random numbers
import random
print(random.randrange(1,10))
print()
#Random module reference https://www.w3schools.com/python/module_random.asp

