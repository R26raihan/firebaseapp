from fastapi import APIRouter, HTTPException
from database import db
from backend.model import UserCreate, UserUpdate, UserLogin
from werkzeug.security import generate_password_hash, check_password_hash

router = APIRouter()
users_ref = db.collection("users")

@router.post("/register")
async def register(user: UserCreate):
    
    if users_ref.document(user.user_id).get().exists:
        raise HTTPException(status_code=400, detail="User already exists")
    
    hashed_password = generate_password_hash(user.password)
    user_data = user.dict()
    user_data["password"] = hashed_password

    users_ref.document(user.user_id).set(user_data)
    return {"message": "User registered successfully"}

@router.post("/login")
async def login(user: UserLogin):
    users = users_ref.where("email", "==", user.email).stream()
    user_doc = next(users, None)
    
    if not user_doc:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    user_data = user_doc.to_dict()
    if not check_password_hash(user_data["password"], user.password):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    return {"message": "Login successful", "user_id": user_doc.id}
