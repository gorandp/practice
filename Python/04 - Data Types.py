#Tutorial: https://www.w3schools.com/python/python_datatypes.asp
#Python has the following data types built-in by default, in these categories:
"""
Text Type:      str
Numeric Types:  int, float, complex
Sequence Types: list, tuple, range
Mapping Type: 	dict
Set Types: 	    set, frozenset
Boolean Type: 	bool
Binary Types: 	bytes, bytearray, memoryview
"""
#See '04 - Python_3._The_standard_type_hierarchy.png' from https://es.wikipedia.org/wiki/Python#Tipos_de_datos

#type() return data type of a variable
x = 5
print(x)
print(type(x))
print()

x = 5.3
print(x)
print(type(x))
print()

x = 'hi'
print(x)
print(type(x))
print()

x = 1+3j
print(x)
print(type(x))
print()

x = ["apple", "banana", "cherry"]
print(x)
print(type(x))
print()

x = ("apple", "banana", "cherry")
print(x)
print(type(x))
print()

x = range(6)
print(x)
print(type(x))
print()

x = {"name" : "John", "age" : 36}
print(x)
print(type(x))
print()

x = {"apple", "banana", "cherry"}
print(x)
print(type(x))
print()

x = frozenset({"apple", "banana", "cherry"})
print(x)
print(type(x))
print()

x = True
print(x)
print(type(x))
print()

x = b"Hello"
print(x)
print(type(x))
print()

x = bytearray(5)
print(x)
print(type(x))
print()

x = memoryview(bytes(5))
print(x)
print(type(x))
print(bytes(5))
print(bytearray(5))
print()


#Setting the Specific Data Type
#Examples	                                    Data Type
x = str("Hello World") 	                       #str
x = int(20) 	                               #int
x = float(20.5) 	                           #float
x = complex(1j) 	                           #complex
x = list(("apple", "banana", "cherry")) 	   #list
x = tuple(("apple", "banana", "cherry")) 	   #tuple
x = range(6) 	                               #range
x = dict(name="John", age=36) 	               #dict
x = set(("apple", "banana", "cherry")) 	       #set
x = frozenset(("apple", "banana", "cherry"))   #frozenset 	
x = bool(5) 	                               #bool
x = bytes(5) 	                               #bytes 	
x = bytearray(5) 	                           #bytearray 	
x = memoryview(bytes(5)) 	                   #memoryview
