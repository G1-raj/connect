from fastapi import FastAPI
from app.routers import auth
from app.database.db import Base, engine

app = FastAPI(
    title="Connect a Dating app",
    version="1.0.0"
)

Base.metadata.create_all(bind=engine)

app.include_router(auth.router)