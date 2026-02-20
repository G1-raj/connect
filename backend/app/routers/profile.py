from fastapi import APIRouter, Depends, HTTPException, status
from app.models import models
from app.utils.dependencies import get_current_user
from app.database.db import get_db
from sqlalchemy.orm import Session, joinedload
from app.schemas.user import UserCreateResponse

router = APIRouter(prefix="/user", tags=["user", "profile"])

@router.get("/profile", response_model=UserCreateResponse, status_code=status.HTTP_200_OK)
def get_user_profile(db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    
    user_id = current_user.id

    user = (
        db.query(models.User)
        .options(
            joinedload(models.UserProfile),
            joinedload(models.UserImages),
            joinedload(models.UserProfileQuestions)
        )
        .filter(
            models.User.id == user_id,
            models.User.is_email_verified == True,
            models.User.is_profile_created == True
        )
        .first()
    )

    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )

    return {
        "message": "User profile fetched successfully",
        "data": user
    }