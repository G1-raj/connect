from enum import Enum

class UserGender(str, Enum):
    male = "male"
    female = "female"
    others = "others"


class UserSexuality(str, Enum):
    straignt = "straight"
    gay = "gay"
    lesbian = "lesbian"
    asexual = "asexual"