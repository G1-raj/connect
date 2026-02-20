from fastapi import APIRouter, Depends, HTTPException, status
from app.database.db import get_db
from sqlalchemy.orm import Session
from app.models import models
from app.utils.dependencies import get_current_user

router = APIRouter(prefix="/profile", tags=["feed"])

@router.get("/feed", status_code=status.HTTP_200_OK)
def generate_feed(db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    pass
