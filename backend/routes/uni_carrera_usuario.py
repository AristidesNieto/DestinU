from fastapi import APIRouter, HTTPException
from models import UniCarreraUsuario
from db import coleccion_ucu

router = APIRouter(prefix="/uni_carrera_usuario", tags=["uni_carrera_usuario"])

@router.post("/")
async def agregar_favorito(data: UniCarreraUsuario):
    result = coleccion_ucu.insert_one(data.dict())
    if not result.inserted_id:
        raise HTTPException(status_code=500, detail="No se pudo guardar el favorito")
    return {"mensaje": "Favorito agregado", "id": str(result.inserted_id)}

@router.get("/{id_usuario}")
async def listar_favoritos(id_usuario: str):
    favoritos = list(coleccion_ucu.find({"id_usuario": id_usuario}))
    return favoritos

@router.delete("/{id_usuario}/{id_uni_carrera}")
async def eliminar_favorito(id_usuario: str, id_uni_carrera: str):
    result = coleccion_ucu.delete_one({
        "id_usuario": id_usuario,
        "id_uni_carrera": id_uni_carrera
    })
    if result.deleted_count == 0:
        raise HTTPException(status_code=404, detail="Favorito no encontrado")
    return {"mensaje": "Favorito eliminado"}