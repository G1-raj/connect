from pydantic import EmailStr, BaseModel

class UserCreate(BaseModel):
    pass

class VerifyOtp(BaseModel):
    pass

class PasswordCreate(BaseModel):
    pass

class UserOut(BaseModel):
    pass

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