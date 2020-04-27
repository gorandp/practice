"""
File based on the YT Tutorial: https://www.youtube.com/watch?v=04J_fL5zg3U
Chair changed to Table!

Another sources read or watched:
- https://es.wikipedia.org/wiki/Factory_Method_(patr%C3%B3n_de_dise%C3%B1o)
- https://realpython.com/factory-method-python/
"""
from abc import ABCMeta, abstractstaticmethod


class ITable(metaclass=ABCMeta):

    @abstractstaticmethod
    def get_dimensions():
        """The Table Interface"""


class BigTable(ITable):

    def __init__(self):
        self.height = 80
        self.width = 80
        self.depth = 80

    def get_dimensions(self):
        return {"height": self.height, "width": self.width, "depth": self.depth}

class MediumTable(ITable):

    def __init__(self):
        self.height = 70
        self.width = 70
        self.depth = 70

    def get_dimensions(self):
        return {"height": self.height, "width": self.width, "depth": self.depth}

class SmallTable(ITable):

    def __init__(self):
        self.height = 60
        self.width = 60
        self.depth = 60

    def get_dimensions(self):
        return {"height": self.height, "width": self.width, "depth": self.depth}


class TableFactory():

    @staticmethod
    def get_table(tabletype):
        try:
            if tabletype == "BigTable":
                return BigTable()
            elif tabletype == "MediumTable":
                return MediumTable()
            elif tabletype == "SmallTable":
                return SmallTable()
            raise AssertionError("Table not found")
        except AssertionError as _e:
            print(_e)

if __name__ == "__main__":
    TABLE = TableFactory.get_table("BigTable")
    print(TABLE.get_dimensions())
    TABLE = TableFactory.get_table("SmallTable")
    print(TABLE.get_dimensions())
    print(f"{TABLE.__class__}")
