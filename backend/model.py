from pydantic import BaseModel, EmailStr

class UserCreate(BaseModel):
    user_id: str
    name: str
    email: EmailStr
    password: str  
    phone: str
    address: str

class UserUpdate(BaseModel):
    name: str
    phone: str
    address: str

class UserLogin(BaseModel):
    email: EmailStr
    password: str
