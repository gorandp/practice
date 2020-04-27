from abc import ABCMeta, abstractstaticmethod
from chair_factory import ChairFactory
from table_factory import TableFactory

class IFurnitureFactory(metaclass=ABCMeta):

    @abstractstaticmethod
    def get_furniture(furniture_type):
        """The static furniture factory interface method"""

class FurnitureFactory(IFurnitureFactory):

    @staticmethod
    def get_furniture(furniture_type):
        try:
            if furniture_type in {"BigChair", "MediumChair", "SmallChair"}:
                return ChairFactory.get_chair(furniture_type)
            elif furniture_type in {"BigTable", "MediumTable", "SmallTable"}:
                return TableFactory.get_table(furniture_type)
            else:
                raise AssertionError("Furniture not found")
        except AssertionError as _e:
            print(_e)
        return None

if __name__ == "__main__":
    FURNITURE = FurnitureFactory.get_furniture("SmallChair")
    print(f"{FURNITURE.__class__} : {FURNITURE.get_dimensions()}")
    FURNITURE = FurnitureFactory.get_furniture("SmallTable")
    print(f"{FURNITURE.__class__} : {FURNITURE.get_dimensions()}")
    FURNITURE = FurnitureFactory.get_furniture("BigTable")
    print(f"{FURNITURE.__class__} : {FURNITURE.get_dimensions()}")
