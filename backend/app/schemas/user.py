from pydantic import EmailStr, BaseModel
from typing import List

class UserSignUp(BaseModel):
    email: EmailStr
    full_name: str

class VerifyOtp(BaseModel):
    otp: str

class PasswordCreate(BaseModel):
    password: str


class UserCreate(BaseModel):
    email: EmailStr
    full_name: str
    date_of_birth: str
    age: int
    is_email_verified: bool
    latitude: float
    longitude: float
    interests: List[str]

class UserOut(BaseModel):
    id: int
    email: EmailStr
    full_name: str
    date_of_birth: str
    age: int
    is_email_verified: bool
    latitude: float
    longitude: float
    interestes: List[str]

class UserCreateResponse(BaseModel):
    message: str
    data: UserOut

class UserLogin(BaseModel):
    pass

class TokenResponse(BaseModel):
    pass

class LoginResponse(BaseModel):
    message: str
    data:UserOut
    token: TokenResponse

class MessageResponse(BaseModel):
    message: str