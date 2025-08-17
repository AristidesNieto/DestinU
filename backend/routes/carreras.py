# routes/carreras.py
from fastapi import APIRouter, Query
from db import carreras

router = APIRouter(prefix="/carreras", tags=["carreras"])

@router.get("")
def listar_carreras(id_area: str | None = Query(default=None, description="Filtra por id_area")):
    filtro = {"id_area": id_area} if id_area else {}
    return list(carreras.find(filtro, {"_id": 0}))