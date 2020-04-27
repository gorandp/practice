"""
File based on the YT Tutorial: https://www.youtube.com/watch?v=04J_fL5zg3U

Another sources read or watched:
- https://es.wikipedia.org/wiki/Factory_Method_(patr%C3%B3n_de_dise%C3%B1o)
- https://realpython.com/factory-method-python/
"""
from abc import ABCMeta, abstractstaticmethod


class IChair(metaclass=ABCMeta):

    @abstractstaticmethod
    def get_dimensions():
        """The Chair Interface"""


class BigChair(IChair):

    def __init__(self):
        self.height = 80
        self.width = 80
        self.depth = 80

    def get_dimensions(self):
        return {"height": self.height, "width": self.width, "depth": self.depth}

class MediumChair(IChair):

    def __init__(self):
        self.height = 70
        self.width = 70
        self.depth = 70

    def get_dimensions(self):
        return {"height": self.height, "width": self.width, "depth": self.depth}

class SmallChair(IChair):

    def __init__(self):
        self.height = 60
        self.width = 60
        self.depth = 60

    def get_dimensions(self):
        return {"height": self.height, "width": self.width, "depth": self.depth}


class ChairFactory():

    @staticmethod
    def get_chair(chairtype):
        try:
            if chairtype == "BigChair":
                return BigChair()
            elif chairtype == "MediumChair":
                return MediumChair()
            elif chairtype == "SmallChair":
                return SmallChair()
            raise AssertionError("Chair not found")
        except AssertionError as _e:
            print(_e)

if __name__ == "__main__":
    CHAIR = ChairFactory.get_chair("BigChair")
    print(CHAIR.get_dimensions())
    CHAIR = ChairFactory.get_chair("SmallChair")
    print(CHAIR.get_dimensions())
    print(f"{CHAIR.__class__}")
