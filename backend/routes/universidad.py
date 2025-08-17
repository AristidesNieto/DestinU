# routes/universidades.py
from fastapi import APIRouter, Query
from db import universidades, uni_carreras

router = APIRouter(prefix="/universidades", tags=["universidades"])

@router.get("")
def listar_universidades():
    return list(universidades.find({}, {"_id": 0}))

@router.get("/por-carreras")
def universidades_por_carreras(
    ids_carrera: str = Query(..., description="ids de carrera separados por coma")
):
    ids = [s.strip() for s in ids_carrera.split(",") if s.strip()]
    rels = list(uni_carreras.find(
        {"id_carrera": {"$in": ids}},
        {"_id": 0, "id_uni": 1, "id_carrera": 1, "id_uniCarrera": 1}
    ))
    if not rels:
        return []
    uni_ids = sorted({r["id_uni"] for r in rels})
    unis = {u["id_uni"]: u for u in universidades.find({"id_uni": {"$in": uni_ids}}, {"_id": 0})}
    # Agregar carreras y ids de relación por universidad
    result = []
    by_uni = {}
    for r in rels:
        by_uni.setdefault(r["id_uni"], []).append({
            "id_carrera": r["id_carrera"],
            "id_uniCarrera": r["id_uniCarrera"]
        })
    for uid, uni in unis.items():
        uni_out = dict(uni)
        uni_out["oferta_match"] = by_uni.get(uid, [])
        result.append(uni_out)
    return result