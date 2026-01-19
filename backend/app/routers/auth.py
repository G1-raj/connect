from fastapi import APIRouter, Depends, HTTPException, status
from database.db import get_db
from models import models
from sqlalchemy.orm import Session
from utils.generate_otp import generate_otp
from utils.security import create_hash, verify_hash
from datetime import datetime, timezone, timedelta
from schemas.user import UserSignUp, VerifyOtp, PasswordCreate, UserCreate, UserCreateResponse, UserLogin, LoginResponse, MessageResponse


router = APIRouter(prefix="/auth", tags=["signup", "login", "user verification", "otp"])

@router.post("/signup", response_model=MessageResponse, status_code=status.HTTP_200_OK)
def signup(user: UserSignUp, db: Session = Depends(get_db)):
    existing_user = db.query(models.User).filter(models.User.email == user.email).first()

    if existing_user and existing_user.is_email_verified:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User already exist and is verified, please login"
        )
    
    if not existing_user:
        new_user = models.User(
            email = user.email,
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
        "message": "Otp sent successfully, please verify your email"
    }
