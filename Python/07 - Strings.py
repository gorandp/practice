# string literals
# in python are surrounded by either single quotation marks, or double quotation marks
print("Hi")
print('Hi')

# assign string to a varible
a = "Hello"
print(a)

# multiline string, could be double or single coutes either
a = """Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."""
print(a)

# string are arrays, so we can access element by element indicating
# the position of the element between square brackets
a = "Hello, World!"
print(a[1])
print()

# slicing
b = "Hello, World!"
print(b[2:5])   # same as print("llo"), so chars 2,3,4 are shown
print(b[-5:-2]) # same as print("orl"), so chars -5,-4,-3 are shown
print(b[-1])    # char 0 is 'H', so -1 is '!'
print()

# len(), returns the length of a str
print(len(b))
print()

# String methods
b = " Hello, World! "
print(b.strip()) # returns "Hello, World!"
b = b.strip()
print(a.lower()) # returns "hello, world!"
print(a.upper()) # returns "HELLO, WORLD!"
print(a.replace("H", "J")) # returns "Jello, World!"
print(a.split(",")) # returns ['Hello', ' World!'] 
print()

# Check string
# Key words "in" or "not in" indicates if a phrase or char is present in a str
txt = "The rain in Spain stays mainly in the plain"
x = "ain" in txt
print(x)
x = "ain" not in txt
print(x)
x = "of" not in txt
print(x)
print()

# String concatenation
a = "Hello"
b = "World"
c = a + b.upper()
print(c)
# or
a = "Hello"
b = "World"
c = a + " " + b.upper()
print(c)

# we cannot mix str with numbers
age = 36
# txt = "My name is John, I am " + age # it gives an error
txt = "My name is John, I am " + str(age)
print(txt) 
# but it is better to use the format() method
age = 36
txt = "My name is John, I am {}"
print(txt.format(age))
# and we can use unlimited number of arguments,
# and they are placed into the respective placeholders
quantity = 3
itemno = 567
price = 49.95
myorder = "I want {} pieces of item {} for {} dollars."
print(myorder.format(quantity, itemno, price))
# also we can use index number between the brackets to use a custom order
myorder = "I want to pay {2} dollars for {0} pieces of item {1}."
print(myorder.format(quantity, itemno, price))
print()

# Escape characters
# To insert characters that are illegal in a string, use an escape character.
# An escape character is a backslash \ followed by the character you want to insert
# txt = "We are the so-called "Vikings" from the north." # will give an error
txt = "We are the so-called \"Vikings\" from the north."
print(txt)

# here are some that I didn't see before
#This example erases one character (backspace):
txt = "Hello \bWorld!"
print(txt) 
#A backslash followed by three integers will result in a octal value:
txt = "\110\145\154\154\157"
print(txt)
#A backslash followed by an 'x' and a hex number represents a hex value:
txt = "\x48\x65\x6c\x6c\x6f"
print(txt)

