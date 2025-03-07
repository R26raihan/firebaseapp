import firebase_admin
from firebase_admin import credentials, firestore
import os


cred_path = r"E:\my_firestore_app\backend\firestore-app-f032d-firebase-adminsdk-fbsvc-59a514f485.json"

if not os.path.exists(cred_path):
    raise Exception(f"File kredensial tidak ditemukan di path: {cred_path}")

cred = credentials.Certificate(cred_path)
firebase_admin.initialize_app(cred)

db = firestore.client()

users_ref = db.collection("users")
