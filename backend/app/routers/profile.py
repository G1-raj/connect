from fastapi import APIRouter, Depends, HTTPException, status
from app.models import models
from app.utils.dependencies import get_current_user
from app.database.db import get_db
from sqlalchemy.orm import Session

router = APIRouter(prefix="/user", tags=["user", "profile"])