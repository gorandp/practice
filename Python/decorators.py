# Tutorial: https://www.datacamp.com/community/tutorials/decorators-python
import functools

def split_string(function):
    @functools.wraps(function)
    def wrapperS():
        func = function()
        splitted_string = func.split()
        return splitted_string

    return wrapperS

def uppercase_decorator(function):
    @split_string
    def wrapper():
        """wrapper docstring"""
        func = function()
        make_uppercase = func.upper()
        return make_uppercase

    return wrapper

@uppercase_decorator
def say_hi():
    """Say hi docstring"""
    return 'hello there'

# decorate = uppercase_decorator(say_hi)
print(say_hi())

print(say_hi.__name__)
print(say_hi.__doc__)


##################################

# Accepting Arguments in Decorator Functions


def decorator_with_arguments(function):
    def wrapper_accepting_arguments(arg1, arg2):
        print("My arguments are: {0}, {1}".format(arg1,arg2))
        function(arg1, arg2)
    return wrapper_accepting_arguments


@decorator_with_arguments
def cities(city_one, city_two):
    print("Cities I love are {0} and {1}".format(city_one, city_two))

cities("Nairobi", "Accra")

##############################



def uppercase_decorator2(func):
    @split_string
    @functools.wraps(func)
    def wrapper():
        """wrapper docstring"""
        return func().upper()
    return wrapper


@uppercase_decorator2
def say_hi2():
    """Say hi docstring"""
    return 'hello there'

say_hi2()

print(say_hi2.__name__)
print(say_hi2.__doc__)
