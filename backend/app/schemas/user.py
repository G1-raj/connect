from pydantic import EmailStr, BaseModel, Field, computed_field
from typing import List
from datetime import date
from app.core.enum import UserGender, UserSexuality
from app.utils.calculate_age import calculate_age


class UserSignUp(BaseModel):
    email: EmailStr
    full_name: str

class VerifyOtp(BaseModel):
    email: EmailStr
    otp: str = Field(..., min_length=6, max_length=6)

class PasswordCreate(BaseModel):
    password: str = Field(..., min_length=6)


class UserCreate(BaseModel):
    description: str
    date_of_birth: date
    gender: UserGender
    sexuality: UserSexuality
    latitude: float
    longitude: float
    interests: List[str]

class ImageData(BaseModel):
    public_id: str
    image_url: str

class UserOut(BaseModel):
    id: int
    email: EmailStr
    full_name: str
    description: str
    date_of_birth: date
    gender: UserGender
    sexuality: UserSexuality
    is_email_verified: bool
    latitude: float
    longitude: float
    interests: List[str]
    images: List[ImageData]

    @computed_field
    def age(self) -> int:
        return calculate_age(self.date_of_birth)

class UserCreateResponse(BaseModel):
    message: str
    data: UserOut

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str

class LoginResponse(BaseModel):
    message: str
    data:UserOut
    token: TokenResponse

class MessageResponse(BaseModel):
    message: str

class VerifyOtpResponse(BaseModel):
    onboarding_token: str
    message: str