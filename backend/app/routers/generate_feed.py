from fastapi import APIRouter, Depends, HTTPException, status
from app.database.db import get_db