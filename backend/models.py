    # models.py
from pydantic import BaseModel, Field
from typing import List, Optional

# Entidades del ERD
class Usuario(BaseModel):
    #id_usuario: str
    correo: str
    contrasena: str
    #id_uniCarrera: Optional[str] = None  # tal cual en el diagrama

class Universidad(BaseModel):
    id_uni: str
    nombre: str
    ubicacion: str
    requisitos: str

class Area(BaseModel):
    id_area: str
    # En el ERD aparece id_carrera aquí, pero la relación correcta la porta Carrera.id_area

class Carrera(BaseModel):
    id_carrera: str
    nombre: str
    id_area: str  # FK a Area

class UniCarrera(BaseModel):
    id_uniCarrera: str
    id_carrera: str  # FK
    id_uni: str      # FK

class UniCarreraUsuario(BaseModel):
    id_uni_carrera_usuario: str
    id_Uni_carrera: str  # FK a UniCarrera
    id_usuario: str      # FK a Usuario

# Payloads de API
class SeleccionCarrerasBody(BaseModel):
    ids_carrera: List[str]

class FavoritosUnisBody(BaseModel):
    ids_uni: List[str]
    ids_carrera: List[str]  # necesarias para mapear a id_uniCarrera exactos

class QuitarFavoritoBody(BaseModel):
    id_uni: str
    id_carrera: Optional[str] = None  # si no se envía, quita todos los pares de esa uni
