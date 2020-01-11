# Python learning

Tutorials used:
    - https://www.w3schools.com/python/

# 01 - Hello world

*TODO*

# 02 - Syntax

*TODO*

# 03 - Variables

*TODO*

# 04 - Data Types

Sources:
- [W3Schools][1]
- [Wikipedia][2]

Python has the following data types built-in by default, in these categories:
- Text Type:      str
- Numeric Types:  int, float, complex
- Sequence Types: list, tuple, range
- Mapping Type: 	dict
- Set Types: 	    set, frozenset
- Boolean Type: 	bool
- Binary Types: 	bytes, bytearray, memoryview

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

# 05 - Numbers

There are three numeric types in Python:
* int
* float
* complex

## Int
* whole number
* positive or negative
* without decimals
* of unlimited length

## Float
* "floating point number"
* is a number, positive or negative
* contain one or more decimals
* can also be scientific numbers with an "e" to indicate the power of 10

## Complex
* the imaginary part is written with a "j" at the end
* real and imaginary numbers could be int or float

## Type Conversion
* You can convert from one type to another with the int(), float(), and complex() methods
* But you cannot convert complex numbers into another number type

## Random
Python does not have a random() function to make a random number, but Python has a built-in module called random that can be used to make random numbers.
```
import random
print(random.randrange(1,10))
```
Output:
```
7
```
It change everytime you run it.

[Random module reference][3]



# For future reading
* [Random module reference][3]


[1]: https://www.w3schools.com/python/python_datatypes.asp
[2]: https://es.wikipedia.org/wiki/Python#Tipos_de_datos
[3]: https://www.w3schools.com/python/module_random.asp