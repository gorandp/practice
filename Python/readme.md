# Python learning

Tutorials used:

- <https://www.w3schools.com/python/>

## 01 - Hello world

- *TODO*

## 02 - Syntax

- *TODO*

## 03 - Variables

- *TODO*

## 04 - Data Types

Sources:

- [W3Schools][1]
- [Wikipedia][2]

Python has the following data types built-in by default, in these categories:

- Text Type: str
- Numeric Types: int, float, complex
- Sequence Types: list, tuple, range
- Mapping Type: dict
- Set Types: set, frozenset
- Boolean Type: bool
- Binary Types: bytes, bytearray, memoryview

type() return data type of a variable

Setting the Specific Data Type:
| Examples | Data Type |
| --- | --- |
| x = str("Hello World") | str |
| x = int(20) | int |
| x = float(20.5) | float |
| x = complex(1j) | complex |
| x = list(("apple", "banana", "cherry")) | list |
| x = tuple(("apple", "banana", "cherry")) | tuple |
| x = range(6) | range |
| x = dict(name="John", age=36) | dict |
| x = set(("apple", "banana", "cherry")) | set |
| x = frozenset(("apple", "banana", "cherry")) | frozenset |
| x = bool(5) | bool |
| x = bytes(5) | bytes |
| x = bytearray(5) | bytearray |
| x = memoryview(bytes(5)) | memoryview |

![Alt text](04_Python_3._The_standard_type_hierarchy.png "Wikipedia: Python 3, The standard type hierarchy")

## 05 - Numbers

There are three numeric types in Python:

- int
- float
- complex

### Int

- whole number
- positive or negative
- without decimals
- of unlimited length

### Float

- "floating point number"
- is a number, positive or negative
- contain one or more decimals
- can also be scientific numbers with an "e" to indicate the power of 10

### Complex

- the imaginary part is written with a "j" at the end
- real and imaginary numbers could be int or float

### Type Conversion

- You can convert from one type to another with the int(), float(), and complex() methods
- But you cannot convert complex numbers into another number type

### Random

Python does not have a random() function to make a random number, but Python has a built-in module called random that can be used to make random numbers.

```python
import random
print(random.randrange(1,10))
```

Output:

```bash
7
```

It change everytime you run it.

[Random module reference][3]

## 06 - Casting

Casting in python is therefore done using constructor functions:

- int() - constructs an integer number from an integer literal, a float literal (by rounding down to the previous whole number), or a string literal (providing the string represents a whole number)
- float() - constructs a float number from an integer literal, a float literal or a string literal (providing the string represents a float or an integer)
- str() - constructs a string from a wide variety of data types, including strings, integer literals and float literals

## 07 - Strings

- String literals: in python are surrounded by either single quotation marks, or double quotation marks
- Multiline Strings: you can assign a multiline string to a variable by using three (single or double) quotes. (the line breaks are inserted at the same position as in the code)
- Strings are arrays of characters. But python doesn't have a character data type, a single char is a str of lenght 1. Square brackets are used to access elements of the string.
- Slice syntax: return a str, selecting a range of char from another str. See "07 - Strings.py"
- len() function: return the lenght of a str
- To check if a str or char is present in a str, we can use the keywords "in" or "not in"
- To concatenate two strings you can use the "+" operator
- Escape characters: To insert characters that are illegal in a string, use an escape character. An escape character is a backslash \ followed by the character you want to insert.

### String methods

All string methods returns new values. They do not change the original string. Some of them are:

- strip(): removes any whitespace from the beginning or the end
- lower(): returns the string in lower case
- upper(): returns the string in upper case
- replace(): replaces a string with another string
- split(): splits the string into substrings if it finds instances of the separator
- format(): takes the passed arguments, formats them, and places them in the string where the placeholders {} are. Also we can add index number between brackets to give another order of placing the passed arguments.

[String methods reference][4]

## 08 - Booleans

Booleans represent one of two values: True or False.

### bool()

It allows you to evaluate any value, and give you True or False in return.
Almost any value is evaluated to True if it has some sort of content.
It returns false when the value is:

- Empty strings
- Number 0
- Empty list, tuple, set or dicrionary.
- Objects that are made from a class with a ```__len__``` function that returns 0 or False.

Python also has many built-in functions that returns a boolean value, like the isinstance() function, which can be used to determine if an object is of a certain data type.

## 09 - Operators

Python divides the operators in the following groups:

- Arithmetic operators
  - Same as C: [```+,-,*,/,%```]
  - New to me: [```**``` : exponentiation, ```//``` : floor division]
- Assignment operators
  - Same as C: [```=,+=,-=,*=,/=```]
  - New to me: [```%=,//=,**=,&=,|=,^=,>>=,<<=```]
- Comparison operators
  - Same as C: [```==,!=,>,<,>=,<=```]
- Logical operators
  - ```and```: Returns True if both statements are true
  - ```or```: Returns True if one of the statements is true
  - ```not```: Reverse the result, returns False if the result is true
- Identity operators
  - ```is```: Returns true if both variables are the same object
  - ```is not```: Returns true if both variables are not the same object
- Membership operators
  - ```in```: Returns True if a sequence with the specified value is present in the object
  - ```not in```: Returns True if a sequence with the specified value is not present in the object
- Bitwise operators
  - Known: [```&``` : AND, ```|``` : OR, ```^``` : XOR]
  - New to me:
    - ```~```: NOT (Inverts all the bits)
    - ```<<```: Zero fill left shift (Shift left by pushing zeros in from the right)
    - ```>>```: Signed right shift (Shift right by pushing copies of the leftmost bit in from the left, and let the rightmost bits fall off)

## 10 - Python Collections (Arrays)

There are four collection data types in the Python programming language:

- List is a collection which is ordered and changeable. Allows duplicate members.
- Tuple is a collection which is ordered and unchangeable. Allows duplicate members.
- Set is a collection which is unordered and unindexed. No duplicate members.
- Dictionary is a collection which is unordered, changeable and indexed. No duplicate members.

When choosing a collection type, it is useful to understand the properties of that type. Choosing the right type for a particular data set could mean retention of meaning, and, it could mean an increase in efficiency or security.

### 10a - Lists

List method | Description
--- | ---
append() | Adds an element at the end of the list
clear() | Removes all the elements from the list
copy() | Returns a copy of the list
count() | Returns the number of elements with the specified value
extend() | Add the elements of a list (or any iterable), to the end of the current list
index() | Returns the index of the first element with the specified value
insert() | Adds an element at the specified position
pop() | Removes the element at the specified position
remove() | Removes the item with the specified value
reverse() | Reverses the order of the list
sort() | Sorts the list

### 10b - Tuples

A tuple is a collection which is ordered and **unchangeable**. In Python tuples are written with round brackets.

Tuples can be accessed the same way as lists.

Tuple Method | Description
--- | ---
count() | Returns the number of times a specified value occurs in a tuple
index() | Searches the tuple for a specified value and returns the position of where it was found

### 10c - Sets

A set is a collection which is unordered and unindexed. In Python sets are written with curly brackets.

Sets are unordered, so you cannot be sure in which order the items will appear.

Set Method | Description
--- | ---
add() | Adds an element to the set
clear() | Removes all the elements from the set
copy() | Returns a copy of the set
difference() | Returns a set containing the difference between two or more sets
difference_update() | Removes the items in this set that are also included in another, specified set
discard() | Remove the specified item
intersection() | Returns a set, that is the intersection of two other sets
intersection_update() | Removes the items in this set that are not present in other, specified set(s)
isdisjoint() | Returns whether two sets have a intersection or not
issubset() | Returns whether another set contains this set or not
issuperset() | Returns whether this set contains another set or not
pop() | Removes an element from the set
remove() | Removes the specified element
symmetric_difference() | Returns a set with the symmetric differences of two sets
symmetric_difference_update() | inserts the symmetric differences from this set and another
union() | Return a set containing the union of sets
update() | Update the set with the union of this set and others

### 10d - Dictionaries

A dictionary is a collection which is unordered, changeable and indexed. In Python dictionaries are written with curly brackets, and they have keys and values.

Dictionary Method | Description
--- | ---
clear() | Removes all the elements from the dictionary
copy() | Returns a copy of the dictionary
fromkeys() | Returns a dictionary with the specified keys and values
get() | Returns the value of the specified key
items() | Returns a list containing a tuple for each key value pair
keys() | Returns a list containing the dictionary's keys
pop() | Removes the element with the specified key
popitem() | Removes the last inserted key-value pair
setdefault() | Returns the value of the specified key. If the key does not exist: insert the key, with the specified value
update() | Updates the dictionary with the specified key-value pairs
values() | Returns a list of all the values in the dictionary

## 11 - Python Conditions and If statements

Python supports the usual logical conditions from mathematics:

- Equals: a == b
- Not Equals: a != b
- Less than: a < b
- Less than or equal to: a <= b
- Greater than: a > b
- Greater than or equal to: a >= b

These conditions can be used in several ways, most commonly in "if statements" and loops.

### The pass Statement

if statements cannot be empty, but if you for some reason have an if statement with no content, put in the pass statement to avoid getting an error.

## 12 - Loops

Python has two primitive loop commands:

- ```while``` loops
- ```for``` loops

### 12a - while

With the ```while``` loop we can execute a set of statements as long as a condition is true.

Statements | Description
--- | ---
```break``` | With the break statement we can stop the loop even if the while condition is true
```continue``` | With the continue statement we can stop the current iteration, and continue with the next
```else``` | With the else statement we can run a block of code once when the condition no longer is true

### 12b - for

A for loop is used for iterating over a sequence (that is either a list, a tuple, a dictionary, a set, or a string).

This is less like the for keyword in other programming languages, and works more like an iterator method as found in other object-orientated programming languages.

With the for loop we can execute a set of statements, once for each item in a list, tuple, set etc.

The for loop does not require an indexing variable to set beforehand.

Statements | Description
--- | ---
```break``` | With the break statement we can stop the loop before it has looped through all the items
```continue``` | With the continue statement we can stop the current iteration of the loop, and continue with the next
```else``` | The else keyword in a for loop specifies a block of code to be executed when the loop is finished
```pass``` | for loops cannot be empty, but if you for some reason have a for loop with no content, put in the pass statement to avoid getting an error.

To loop through a set of code a specified number of times, we can use the ```range()``` function. The ```range()``` function returns a sequence of numbers, starting from 0 by default, and increments by 1 (by default), and ends at a specified number.

## For future reading

- [Random module reference][3]
- [String methods reference][4]
- [Request module used for file download][5]

[1]: https://www.w3schools.com/python/python_datatypes.asp
[2]: https://es.wikipedia.org/wiki/Python#Tipos_de_datos
[3]: https://www.w3schools.com/python/module_random.asp
[4]: https://www.w3schools.com/python/python_ref_string.asp
[5]: https://stackabuse.com/download-files-with-python/
