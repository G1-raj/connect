from passlib.context import CryptContext

pwd_context = CryptContext(
    schemes=["argon2"],
    deprecated="auto"
)

def create_hash(plain_text: str) -> str:
    return pwd_context.hash(plain_text)

def verify_hash(plain_text: str, hash: str) -> bool:
    return pwd_context.verify(plain_text, hash)