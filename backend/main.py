from fastapi import FastAPI, HTTPException
from model import UserCreate, UserLogin, UserUpdate
import firebase_admin
from firebase_admin import credentials, auth, firestore
import uuid

app = FastAPI()

# Inisialisasi Firebase
cred = credentials.Certificate(r"E:\my_firestore_app\backend\firestore-app-f032d-firebase-adminsdk-fbsvc-59a514f485.json")
firebase_admin.initialize_app(cred)
db = firestore.client()
users_ref = db.collection('users')

@app.post("/users/register")
async def register_user(user: UserCreate):
    try:
        # Buat pengguna baru di Firebase Auth
        firebase_user = auth.create_user(
            email=user.email,
            password=user.password,
        )

        # Simpan data tambahan ke Firestore
        user_dict = user.dict()
        user_dict["user_id"] = firebase_user.uid  # Gunakan UID dari Firebase Auth
        users_ref.document(firebase_user.uid).set(user_dict)

        return {"message": "User registered successfully", "user_id": firebase_user.uid}
    except auth.EmailAlreadyExistsError:
        raise HTTPException(status_code=400, detail="Email already registered")
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.post("/users/login")
async def login_user(user: UserLogin):
    try:
        # Verifikasi email dan password menggunakan Firebase Auth
        firebase_user = auth.get_user_by_email(user.email)
        
        # Jika berhasil, kembalikan UID pengguna
        return {"message": "Login successful", "user_id": firebase_user.uid}
    except auth.UserNotFoundError:
        raise HTTPException(status_code=400, detail="User not found")
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.get("/users/{user_id}")
async def get_user(user_id: str):
    user_doc = users_ref.document(user_id).get()
    if not user_doc.exists:
        raise HTTPException(status_code=404, detail="User not found")
    return user_doc.to_dict()

@app.put("/users/{user_id}")
async def update_user(user_id: str, user: UserUpdate):
    user_doc = users_ref.document(user_id).get()
    if not user_doc.exists:
        raise HTTPException(status_code=404, detail="User not found")

    # Update user data in Firestore
    user_dict = user.dict(exclude_unset=True)  # Only update provided fields
    users_ref.document(user_id).update(user_dict)

    return {"message": "User updated successfully"}

@app.delete("/users/{user_id}")
async def delete_user(user_id: str):
    user_doc = users_ref.document(user_id).get()
    if not user_doc.exists:
        raise HTTPException(status_code=404, detail="User not found")

    users_ref.document(user_id).delete()
    return {"message": "User deleted successfully"}