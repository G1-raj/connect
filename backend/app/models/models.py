from sqlalchemy import Boolean, Column, DateTime, ForeignKey, Float, Integer, JSON, String
from sqlalchemy.orm import relationship
from database.db import Base
from datetime import datetime, timezone


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    email = Column(String, unique=True, nullable=False)
    full_name = Column(String, nullable=False)
    otp = Column(String, nullable=True)
    hashed_password = Column(String, nullable=True)
    description = Column(String, nullable=True)
    date_of_birth = Column(
        DateTime(timezone=True),
        nullable=True
    )
    age = Column(Integer, nullable=True)
    is_email_verified = Column(Boolean, nullable=False, default=False)
    longitude = Column(Float, nullable=True)
    latitude = Column(Float, nullable=True)
    interests = Column(JSON, nullable=True)
