from fastapi import APIRouter, Depends, HTTPException, status, BackgroundTasks, UploadFile, File
from app.database.db import get_db
from app.models import models
from sqlalchemy.orm import Session, joinedload
from app.utils.generate_otp import generate_otp
from app.utils.security import create_hash, verify_hash
from app.utils.jwt import create_access_token, create_refresh_token, create_onboarding_token
from app.utils.dependencies import get_onboarding_user, validate_refresh_token, get_current_user
from app.utils.send_email import send_mail
from app.utils.email_template import otp_email_template
from app.utils.cloudinary_service import upload_image, delete_image
from datetime import datetime, timezone, timedelta
from typing import List
from app.schemas.user import (
    UserSignUp, 
    VerifyOtp, 
    PasswordCreate, 
    UserCreate, 
    UserQuestionCreate,
    UserCreateResponse, 
    UserLogin, 
    LoginResponse, 
    MessageResponse, 
    VerifyOtpResponse,
    TokenResponse
)


router = APIRouter(prefix="/auth", tags=["signup", "login", "user verification", "otp"])

@router.post("/signup", response_model=MessageResponse, status_code=status.HTTP_200_OK)
def signup(user: UserSignUp, background_tasks: BackgroundTasks, db: Session = Depends(get_db)):

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

    print(otp)

    new_otp = models.EmailOtp(
        user_id = user_obj.id,
        otp_hash = hashed_otp,
        expires_at = datetime.now(timezone.utc) + timedelta(minutes=5),
        attempts = 0
    )

    db.add(new_otp)
    db.commit()

    background_tasks.add_task(send_mail, to_email = email, subject = "Verify your email", body = otp_email_template(otp))

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

@router.post("/create-profile", response_model=MessageResponse, status_code=status.HTTP_201_CREATED)
def create_profile(user: UserCreate, db: Session = Depends(get_db), onboarding_user: models.User = Depends(get_onboarding_user)):
    
    current_user = onboarding_user

    if current_user.hashed_password is None:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Please create password"
        )
    
    if current_user.is_profile_created:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="Profile already created"
        )

    user_profile = (
        db.query(models.UserProfile)
        .filter(
            models.UserProfile.user_id == current_user.id
        )
        .first()
    )

    if not user_profile:
        user_profile = models.UserProfile(
            description = user.description,
            date_of_birth = user.date_of_birth,
            gender = user.gender,
            sexuality = user.sexuality,
            longitude = user.longitude,
            latitude = user.latitude,
            user_id = current_user.id
        )
        db.add(user_profile)

    current_user.is_profile_created = True
    db.commit()
    db.refresh(user_profile)

    return {
        "message": "Profile created successfully",
        # "data": current_user
    }


#usercreateresponse
@router.post("/upload-pictures", response_model=MessageResponse, status_code=status.HTTP_201_CREATED)
def upload_profile_pictures(files: List[UploadFile] = File(...),db: Session = Depends(get_db), onboarding_user: models.User = Depends(get_onboarding_user)):

    current_user = onboarding_user

    if len(files) == 0:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="At least one image is required"
        )
    
    if len(files) > 6:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Maximum 6 images are allowed"
        )
    
    existing_count = len(current_user.user_images)

    if existing_count + len(files) > 6:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Image limit exceeded"
        )
    
    uploaded_images = []

    for file in files:
        upload_result = upload_image(
            file.file,
            folder = f"connect/users/{current_user.id}"
        )

        image = models.UserImages(
            user_id = current_user.id,
            image_url=upload_result["image_url"],
            public_id=upload_result["public_id"]
        )

        db.add(image)
        uploaded_images.append(image)

    db.commit()

    # return current_user
    return {
        "message": "Image uploaded"
    }


@router.delete("/delete-image/{image_id}", response_model=MessageResponse, status_code=status.HTTP_200_OK)
def delete_image(image_id: int, db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    image = (
        db.query(models.UserImages)
        .filter(
            models.UserImages.id == image_id,
            models.UserImages.user_id == current_user.id
        )
        .first()
    )

    if not image:
        raise HTTPException(
            status_code = status.HTTP_404_NOT_FOUND,
            detail = "Image not found"
        )
    
    delete_image(image.public_id)
    db.delete(image.id)
    db.commit()

    return {
        "message": "Image deleted"
    }

# UserCreateResponse
@router.post("/user-questions", response_model=MessageResponse, status_code=status.HTTP_200_OK)
def add_user_questions(user_questions: UserQuestionCreate, db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    existing_user = current_user

    questions = (
        db.query(models.UserProfileQuestions)
        .filter(
            models.UserProfileQuestions.user_id == existing_user.id
        )
        .first()
    )

    if questions:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Questions are already answered"
        )

    questions_answered = models.UserProfileQuestions(
        alcohol = user_questions.alcohol,
        smoke = user_questions.smoke,
        kids = user_questions.kids,
        exercise = user_questions.exercise,
        pets = user_questions.pets,
        user_id = existing_user.id
    )

    db.add(questions_answered)
    db.commit()
    db.refresh(questions_answered)

    return {
        "message": "Answers noted"
    }



@router.post("/login", response_model=LoginResponse, status_code=status.HTTP_200_OK)
def login(user: UserLogin, db: Session = Depends(get_db)):
    email = user.email.strip().lower()

    existing_user = (
        db.query(models.User)
        .options(
            joinedload(models.User.user_profile),
            joinedload(models.User.user_profile_questions),
            joinedload(models.User.user_images)
        )
        .filter(
            models.User.email == email,
            models.User.is_email_verified == True,
            models.User.is_profile_created == True,
            models.User.hashed_password.isnot(None)
        )
        .first()
    )
    
    if not existing_user or not verify_hash(user.password, existing_user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid credentials"
        )
    
    access_token = create_access_token(
        data = { "sub": str(existing_user.id) }
    )

    refresh_token = create_refresh_token(
        data= { "sub": str(existing_user.id) }
    )

    existing_user.hashed_refresh_token = create_hash(refresh_token)
    db.commit()

    profile = existing_user.user_profile
    questions = existing_user.user_profile_questions
    user_data = {
        "id": existing_user.id,
        "email": existing_user.email,
        "full_name": existing_user.full_name,
        "description": profile.description,
        "date_of_birth": profile.date_of_birth,
        "gender": profile.gender,
        "sexuality": profile.sexuality,
        "is_email_verified": existing_user.is_email_verified,
        "latitude": profile.latitude,
        "longitude": profile.longitude,
        "interests": profile.interests,
        "images": existing_user.user_images,
        "alcohol": questions.alcohol,
        "smoke": questions.smoke,
        "pets": questions.pets,
        "kids": questions.kids,
        "exercise": questions.exercise,
    }

    return {
        "message": "User login successful",
        "data": user_data,
        "token": {
            "access_token": access_token,
            "refresh_token": refresh_token
        }
    }

     
@router.post("/refresh-token", response_model=TokenResponse, status_code=status.HTTP_200_OK)
def refresh_token(db: Session = Depends(get_db), user: models.User = Depends(validate_refresh_token)):
    
    new_access_token = create_access_token(
        data= { "sub": str(user.id) }
    )

    new_refresh_token = create_refresh_token(
        data = { "sub": str(user.id) }
    )

    user.hashed_refresh_token = create_hash(new_refresh_token)
    db.commit()

    return {
        "access_token": new_access_token,
        "refresh_token": new_refresh_token
    }

@router.post("/logout", response_model=MessageResponse, status_code=status.HTTP_200_OK)
def logout(db: Session = Depends(get_db), user: models.User = Depends(get_current_user)):

    user.hashed_refresh_token = None
    db.commit()

    return {
        "message": "User logged out succesfully"
    }