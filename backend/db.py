# db.py
from pymongo import MongoClient, ASCENDING
from dotenv import load_dotenv
import os

load_dotenv()
client = MongoClient(os.getenv("MONGO_URI"))
db = client["career_db"]

usuario = db["usuario"]
universidades = db["universidad"]
areas = db["area"]
carreras = db["carrera"]
uni_carreras = db["uni_carrera"]
uni_carrera_usuario = db["uni_carrera_usuario"]

# Índices y unicidad
usuario.create_index([("id_usuario", ASCENDING)], unique=True)
universidades.create_index([("id_uni", ASCENDING)], unique=True)
areas.create_index([("id_area", ASCENDING)], unique=True)
carreras.create_index([("id_carrera", ASCENDING)], unique=True)
carreras.create_index([("id_area", ASCENDING)])
uni_carreras.create_index([("id_uniCarrera", ASCENDING)], unique=True)
uni_carreras.create_index([("id_carrera", ASCENDING)])
uni_carreras.create_index([("id_uni", ASCENDING)])
# Evita duplicados de favoritos por usuario-par
uni_carrera_usuario.create_index(
    [("id_usuario", ASCENDING), ("id_Uni_carrera", ASCENDING)],
    unique=True
)
coleccion_ucu = uni_carrera_usuario