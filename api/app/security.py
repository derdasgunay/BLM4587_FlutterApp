from datetime import datetime, timedelta, timezone
from argon2 import PasswordHasher
import jwt
from argon2.exceptions import VerifyMismatchError
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session

from app.config import settings
from app.db import get_db
from app.models.user import User

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/login")

hasher = PasswordHasher()


def hash_password(password: str) -> str:
    return _hasher.hash(password)
    
def verify_password(password: str, password_hash: str)-> bool:
    try:
        return _hasher.verify(password_hash, password)
    except VerifyMismatchError:     
        return False

def create_access_token(user: User) -> str:
    expire = datetime.now(timezone.utc) + timedelta(minutes=settings.access_token_expire_minutes)
    payload = {"sub": str(user.id), "role": user.role.value, "exp": expire}
    return jwt.encode(payload, settings.jwt_secret_key, algorithm= settings.jwt_algorithm)

def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)) -> User:
    error = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Oturum geçersiz",
        headers={"WWW-Authenticate": "Bearer"},)
    
    try:
        payload= jwt.decode(token, settings.jwt_secret_key, algorithms=[settings.jwt_algorithm])
        user_id = int(payload["sub"])
    
    except(jwt.InvalidTokenError, KeyError, ValueError):
        raise error
    user = db.get(User, user_id)
    if user is None:
        raise error
    return user