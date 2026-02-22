from fastapi import APIRouter, Depends, HTTPException, status
from app.database.db import get_db
from sqlalchemy.orm import Session, joinedload
from app.models import models
from app.utils.dependencies import get_current_user

router = APIRouter(prefix="/profile", tags=["feed"])

@router.get("/feed", status_code=status.HTTP_200_OK)
def generate_feed(db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    user = (
        db.query(models.User)
        .options(
            joinedload(models.UserProfile),
            joinedload(models.UserImages),
            joinedload(models.UserProfileQuestions)
        )
        .filter(
            models.User.id != current_user.id,
            models.User.is_email_verified == True,
            models.User.is_profile_created == True
        )
    )
