from fastapi import APIRouter, Depends, HTTPException, status
from app.database.db import get_db
from sqlalchemy.orm import Session, joinedload
from app.models import models
from app.utils.dependencies import get_current_user
from sqlalchemy import func

router = APIRouter(prefix="/profile", tags=["feed"])

#radius 50 km
RADIUS_KM = 50


#feed router
@router.get("/feed", status_code=status.HTTP_200_OK)
def generate_feed(db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    users = (
        db.query(models.User)
        .join(models.UserProfile)
        .options(
            joinedload(models.UserImages),
            joinedload(models.UserProfileQuestions)
        )
        .filter(
            models.User.id != current_user.id,
            models.User.is_email_verified == True,
            models.User.is_profile_created == True,
            func.sqrt(
                func.pow(models.UserProfile.latitude - current_user.profile.latitude, 2) +
                func.pow(models.UserProfile.longitude - current_user.profile.longitude, 2)
            ) < 0.5
        )
        .limit(20)
        .all()
    )

    return {
        "message": "Feed generated successfully",
        "data": users
    }
