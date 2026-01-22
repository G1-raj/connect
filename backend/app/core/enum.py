from enum import Enum

class UserGender(str, Enum):
    male = "male"
    female = "female"
    others = "others"