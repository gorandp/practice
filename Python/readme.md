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

## For future reading

- [Random module reference][3]
- [String methods reference][4]
- [Request module used for file download][5]

[1]: https://www.w3schools.com/python/python_datatypes.asp
[2]: https://es.wikipedia.org/wiki/Python#Tipos_de_datos
[3]: https://www.w3schools.com/python/module_random.asp
[4]: https://www.w3schools.com/python/python_ref_string.asp
[5]: https://stackabuse.com/download-files-with-python/
