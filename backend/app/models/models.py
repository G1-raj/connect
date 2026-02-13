from sqlalchemy import Boolean, Column, Date, DateTime, ForeignKey, Float, Integer, JSON, String, Enum as SQLEnum
from sqlalchemy.orm import relationship
from app.database.db import Base
from datetime import datetime, timezone
from app.core.enum import UserGender, UserSexuality


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    email = Column(String, unique=True, nullable=False, index=True)
    full_name = Column(String, nullable=False)
    hashed_password = Column(String, nullable=True)
    description = Column(String, nullable=True)
    date_of_birth = Column(
        Date,
        nullable=True
    )
    # age = Column(Integer, nullable=True)
    gender = Column(
        SQLEnum(UserGender),
        nullable=True
    )
    sexuality = Column(
        SQLEnum(UserSexuality),
        default=UserSexuality.straignt
    )
    is_email_verified = Column(Boolean, nullable=False, default=False)
    longitude = Column(Float, nullable=True)
    latitude = Column(Float, nullable=True)
    interests = Column(JSON, nullable=True)
    is_profile_created = Column(Boolean, default=False)
    hashed_refresh_token = Column(String, nullable=True)

    created_at = Column(
        DateTime(timezone=True),
        default= lambda: datetime.now(timezone.utc),
        nullable=False
    )

    updated_at = Column(
        DateTime(timezone=True),
        default= lambda: datetime.now(timezone.utc),
        onupdate= lambda: datetime.now(timezone.utc),
        nullable=False
    )

    email_otps = relationship("EmailOtp", back_populates="owner", cascade="all, delete-orphan")
    user_images = relationship("UserImages", back_populates="owner", cascade="all, delete-orphan")
    user_profile_questions = relationship("UserProfileQuestions", back_populates="owner", cascade="add, delete-orphan")


class EmailOtp(Base):
    __tablename__ = "email_otps"

    id = Column(Integer, primary_key=True)
    # email = Column(String, index=True, nullable=False)
    otp_hash = Column(String, nullable=False)
    expires_at = Column(DateTime(timezone=True), nullable=False)
    attempts = Column(Integer, default=0)
    created_at = Column(
        DateTime(timezone=True),
        default= lambda: datetime.now(timezone.utc)
    )

    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    owner = relationship("User", back_populates="email_otps")

class UserImages(Base):
    __tablename__ = "user_images"

    id = Column(Integer, primary_key=True)
    # email = Column(String, nullable=False, index=True)
    image_url = Column(String, nullable=False)
    public_id = Column(String, nullable=False)
    created_at = Column(
        DateTime(timezone=True),
        default= lambda: datetime.now(timezone.utc)
    )
    updated_at = Column(
        DateTime(timezone=True),
        default= lambda: datetime.now(timezone.utc),
        onupdate= lambda: datetime.now(timezone.utc)
    )

    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    owner = relationship("User", back_populates="user_images")


class UserProfileQuestions(Base):
    __tablename__ = "user_profile_questions"

    id = Column(Integer, primary_key=True)

    alcohol = Column(Boolean, default=False)
    smoke = Column(Boolean, default=False)
    pets = Column(Boolean, default=False)
    kids = Column(Boolean, default=False)
    exercise = Column(Boolean, default=False)

    created_at = Column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
    )

    updated_at = Column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        onupdate=lambda: datetime.now(timezone.utc)
    )

    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    owner = relationship("User", back_populates="user_profile_questions")


