# routes/usuario.py
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from db import usuario
from models import Usuario
from uuid import uuid4



router = APIRouter(prefix="/usuario", tags=["usuario"])

@router.post("")
def crear_usuario(u: Usuario):
    print("DEBUG recibido:", u.dict())

    # 1. Verificar si el correo ya está registrado
    existe = usuario.find_one({"correo": u.correo})
    print("DEBUG existe:", existe)
    if existe:
        raise HTTPException(status_code=409, detail="Correo ya registrado")

    # 2. Generar id_usuario único
    id_usuario = str(uuid4())

    # 3. Construir documento limpio
    nuevo_usuario = u.dict()
    nuevo_usuario["id_usuario"] = id_usuario

    # 4. Insertar en la BD
    resultado = usuario.insert_one(nuevo_usuario)
    print("DEBUG insertado _id:", resultado.inserted_id)

    return {
        "mensaje": "Usuario creado",
        "id_usuario": id_usuario
    }


class Credenciales(BaseModel):
    correo: str
    contrasena: str

@router.post("/por-credenciales")
def obtener_usuario(cred: Credenciales):
    u = usuario.find_one(
        {"correo": cred.correo, "contrasena": cred.contrasena},
        {"_id": 0, "contrasena": 0}
    )
    if not u:
        raise HTTPException(status_code=404, detail="Usuario o contraseña incorrectos")
    return u