# routes/areas.py
from fastapi import APIRouter
from db import areas

router = APIRouter(prefix="/areas", tags=["areas"])

@router.get("")
def listar_areas():
    return list(areas.find({}, {"_id": 0}))