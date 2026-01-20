from fastapi import APIRouter, Depends, HTTPException, status
from database.db import get_db
from models import models
from sqlalchemy.orm import Session
from utils.generate_otp import generate_otp
from utils.security import create_hash, verify_hash
from utils.jwt import create_access_token, create_refresh_token, create_onboarding_token
from utils.dependencies import get_onboarding_user
from datetime import datetime, timezone, timedelta
from schemas.user import UserSignUp, VerifyOtp, PasswordCreate, UserCreate, UserCreateResponse, UserLogin, LoginResponse, MessageResponse, VerifyOtpResponse


router = APIRouter(prefix="/auth", tags=["signup", "login", "user verification", "otp"])

@router.post("/signup", response_model=MessageResponse, status_code=status.HTTP_200_OK)
def signup(user: UserSignUp, db: Session = Depends(get_db)):

    email = user.email.strip().lower()

    if not email.endswith("@gmail.com"):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid email, we support only @gmail.com"
        )

    existing_user = db.query(models.User).filter(models.User.email == email).first()

    if existing_user and existing_user.is_email_verified:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User already exist and is verified, please login"
        )
    
    if not existing_user:
        new_user = models.User(
            email = email,
            full_name = user.full_name
        )

        db.add(new_user)
        db.commit()
        db.refresh(new_user)

        user_obj = new_user
    else:
        user_obj = existing_user


    otp = generate_otp()
    hashed_otp = create_hash(otp)

    new_otp = models.EmailOtp(
        user_id = user_obj.id,
        otp_hash = hashed_otp,
        expires_at = datetime.now(timezone.utc) + timedelta(minutes=5),
        attempts = 0
    )

    db.add(new_otp)
    db.commit()

    return {
        "message": "Otp sent successfully, Please verify your email"
    }


@router.post("/verify-otp", response_model=VerifyOtpResponse, status_code=status.HTTP_200_OK)
def verify_otp(otp: VerifyOtp, db: Session = Depends(get_db)):

    email = otp.email.strip().lower()
    
    existing_user = (
        db.query(models.User)
        .filter(models.User.email == email)
        .first()
    )

    if not existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User does not exist"
        )

    get_otp = (
        db.query(models.EmailOtp)
        .filter(models.EmailOtp.user_id == existing_user.id, models.EmailOtp.expires_at > datetime.now(timezone.utc))
        .order_by(models.EmailOtp.created_at.desc())
        .first()
    )

    if not get_otp:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Otp does not exist"
        )
    
    if get_otp.attempts < 4:
        check_otp = verify_hash(otp.otp, get_otp.otp_hash)

        if check_otp:
            db.delete(get_otp)
            existing_user.is_email_verified = True
            onboarding_token = create_onboarding_token(
                data = { "sub": str(existing_user.id) }
            )
            db.commit()
        else:
            get_otp.attempts += 1
            db.commit()
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Otp is invalid"
            )
    else:
        db.delete(get_otp)
        db.commit()
        raise HTTPException(
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            detail="You have exceeded the maximum OTP attempts"
        )
        
    return {
        "onboarding_token": onboarding_token,
        "message": "Email verified successfully"
    }

@router.post("/create-password", response_model=MessageResponse, status_code=status.HTTP_201_CREATED)
def create_password(user: PasswordCreate, db: Session = Depends(get_db), onboarding_user: models.User = Depends(get_onboarding_user)):

     current_user = onboarding_user

     if not current_user:
         raise HTTPException(
             status_code=status.HTTP_400_BAD_REQUEST,
             detail="Invalid request"
         )
     
     if current_user.hashed_password is not None:
         raise HTTPException(
             status_code=status.HTTP_400_BAD_REQUEST,
             detail="Password already exist"
         )
     
     if len(user.password) < 7 or len(user.password) > 12:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Password length should between 7 to 12 characters"
        )
     
     hashed_password = create_hash(user.password)

     current_user.hashed_password = hashed_password

     db.commit()

     return {
         "message": "Password set successfully"
     }

@router.post("/create-profile", response_model=UserCreateResponse, status_code=status.HTTP_201_CREATED)
def create_profile(user: UserCreate, db: Session = Depends(get_db)):
    
    email = user.email.strip().lower()

    existing_user = (
        db.query(models.User)
        .filter(
            models.User.email == email,
            models.User.is_email_verified == True
        )
        .first()
    )

    if not existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User does not exist please signup"
        )
    
    existing_user.description = user.description
    existing_user.date_of_birth = user.date_of_birth
    existing_user.longitude = user.longitude
    existing_user.latitude = user.latitude
    existing_user.interests = user.interests

    db.commit()

    return existing_user
     

