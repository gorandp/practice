# Arithmetic Operators
# Same as C -> [+,-,*,/,%]
# New to me -> [** : exponentiation, // : floor division]

x = 2
y = 5
print(x ** y) # exponentiation
x = 15
y = 2
print(x // y) # floor division -> exact div = 7.5 | floor div = 7
print()


# Logical operators
# and, or, not
x = 5
print(x > 3 and x < 10) # returns True
print(x > 3 or x < 4)   # returns True
print(not(x > 3 and x < 10)) # returns False
print()

# Identity operators
# is: Returns true if both variables are the same object
# is not: Returns true if both variables are not the same object

# is
x = ["apple", "banana"]
y = ["apple", "banana"]
z = x
print(x is z)
# returns True because z is the same object as x
print(x is y)
# returns False because x is not the same object as y, even if they have the same content
print(x == y)
# to demonstrate the difference betweeen "is" and "==": this comparison returns True because x is equal to y
z = ["orange", "pineapple"]
print(z)
print(x)
print(x is z)
# returns False because now z is not the same object as x

# is not
print(x is not y)
# returns True because x is not the same object as y, even if they have the same content
print(x != y)
# to demonstrate the difference betweeen "is not" and "!=": this comparison returns False because x is equal to y
print()


# Membership operators
# in: Returns True if a sequence with the specified value is present in the object
# not in: Returns True if a sequence with the specified value is not present in the object
x = ["apple", "banana"]
print("banana" in x)
# returns True because a sequence with the value "banana" is in the list
print("orange" not in x)
# returns True because a sequence with the value "orange" is not in the list
print()


# Bitwise operators
# Known -> [& : AND, | : OR, ^ : XOR]
# New   -> [~ : NOT, << : Zero fill left shift, >> : Signed right shift]

# << (Zero fill left shift)
x = 500
# base 2: x = 1 1111 0100
x <<= 2
# base 2: x = 1 1111 0100<-00 (it inserts zeros from the right)
# base 2: x = 0111 1101 0000
# base 10:x = 2000
print(x)

# >> (Signed right shift)
x = 500
# base 2: x = 0001 1111 0100
x >>= 5
# base 2: x = 00000->0001 111|bit fall|1 0100 (it inserts zeros from the left)
# base 2: x = 1111                            (and let the rightmost bits fall off)
# base 10:x = 15
print(x)

# ~ (NOT)
x = 500
x = ~(x)
# base 2: x = ~(0001 1111 0100)
# base 2: x =   1110 0000 1011
# base 10:x = -501
# Not understanding why
print(x)