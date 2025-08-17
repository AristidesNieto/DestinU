# seed.py
# Carga 9 áreas, 2 carreras por área, 10 universidades y relaciones uni_carrera.

from db import areas, carreras, universidades, uni_carreras
from pymongo import UpdateOne

# 1) ÁREAS (9)
areas_data = [
    {"id_area": "AR_HUM", "nombre": "Humanidades"},
    {"id_area": "AR_INGTEC", "nombre": "Ingenieria y Tecnologia"},
    {"id_area": "AR_SOC", "nombre": "Ciencias Sociales"},
    {"id_area": "AR_SALUD", "nombre": "Ciencias de la Salud"},
    {"id_area": "AR_ADM", "nombre": "Administracion y Negocios"},
    {"id_area": "AR_ARQ", "nombre": "Arte y Arquitectura"},
    {"id_area": "AR_EDU", "nombre": "Educacion"},
    {"id_area": "AR_AGRO", "nombre": "Ciencias Agropecuarias"},
    {"id_area": "AR_EXACT", "nombre": "Ciencias Exactas"},
]

# 2) CARRERAS (2 por área)
carreras_por_area = {
    "AR_HUM": [
        {"id_carrera": "CAR_HUM_1", "nombre": "Filosofia"},
        {"id_carrera": "CAR_HUM_2", "nombre": "Literatura"},
    ],
    "AR_INGTEC": [
        {"id_carrera": "CAR_ING_1", "nombre": "Ingenieria Mecanica"},
        {"id_carrera": "CAR_ING_2", "nombre": "Ingenieria en Sistemas"},
    ],
    "AR_SOC": [
        {"id_carrera": "CAR_SOC_1", "nombre": "Sociologia"},
        {"id_carrera": "CAR_SOC_2", "nombre": "Ciencia Politica"},
    ],
    "AR_SALUD": [
        {"id_carrera": "CAR_SAL_1", "nombre": "Medicina"},
        {"id_carrera": "CAR_SAL_2", "nombre": "Enfermeria"},
    ],
    "AR_ADM": [
        {"id_carrera": "CAR_ADM_1", "nombre": "Administracion"},
        {"id_carrera": "CAR_ADM_2", "nombre": "Contaduria"},
    ],
    "AR_ARQ": [
        {"id_carrera": "CAR_ARQ_1", "nombre": "Arquitectura"},
        {"id_carrera": "CAR_ARQ_2", "nombre": "Diseno Grafico"},
    ],
    "AR_EDU": [
        {"id_carrera": "CAR_EDU_1", "nombre": "Pedagogia"},
        {"id_carrera": "CAR_EDU_2", "nombre": "Educacion Especial"},
    ],
    "AR_AGRO": [
        {"id_carrera": "CAR_AGR_1", "nombre": "Agronomia"},
        {"id_carrera": "CAR_AGR_2", "nombre": "Zootecnia"},
    ],
    "AR_EXACT": [
        {"id_carrera": "CAR_EXA_1", "nombre": "Matematicas"},
        {"id_carrera": "CAR_EXA_2", "nombre": "Fisica"},
    ],
}

# 3) UNIVERSIDADES (10)
universidades_data = [
    {"id_uni": "UNI_TECMTY", "nombre": "Tec de Monterrey", "ubicacion": "Monterrey, NL", "requisitos": "Promedio >= 8.0"},
    {"id_uni": "UNI_UNAM", "nombre": "UNAM", "ubicacion": "CDMX", "requisitos": "Examen de admision"},
    {"id_uni": "UNI_UIBERO", "nombre": "Universidad Iberoamericana", "ubicacion": "CDMX", "requisitos": "Proceso interno"},
    {"id_uni": "UNI_UPAN", "nombre": "Universidad Panamericana", "ubicacion": "CDMX", "requisitos": "Proceso interno"},
    {"id_uni": "UNI_ITAM", "nombre": "ITAM", "ubicacion": "CDMX", "requisitos": "Examen + entrevista"},
    {"id_uni": "UNI_COLMEX", "nombre": "Colegio de Mexico", "ubicacion": "CDMX", "requisitos": "Proceso selectivo"},
    {"id_uni": "UNI_ANAHUAC", "nombre": "Universidad Anahuac", "ubicacion": "CDMX", "requisitos": "Proceso interno"},
    {"id_uni": "UNI_IPN", "nombre": "Instituto Politecnico Nacional", "ubicacion": "CDMX", "requisitos": "Examen de admision"},
    {"id_uni": "UNI_UAM", "nombre": "Universidad Autonoma Metropolitana", "ubicacion": "CDMX", "requisitos": "Examen de admision"},
    {"id_uni": "UNI_UDG", "nombre": "Universidad de Guadalajara", "ubicacion": "Guadalajara, JAL", "requisitos": "Examen de admision"},
]

def upsert_many(col, key_field, docs):
    ops = [UpdateOne({key_field: d[key_field]}, {"$set": d}, upsert=True) for d in docs]
    if not ops:
        return {"matched": 0, "upserted": 0, "modified": 0}
    res = col.bulk_write(ops, ordered=False)
    return {"matched": res.matched_count, "upserted": len(res.upserted_ids), "modified": res.modified_count}

def main():
    print("Upserting areas...")
    print(upsert_many(areas, "id_area", areas_data))

    print("Upserting carreras...")
    carreras_docs = []
    for id_area, lista in carreras_por_area.items():
        for c in lista:
            carreras_docs.append({**c, "id_area": id_area})
    print(upsert_many(carreras, "id_carrera", carreras_docs))

    print("Upserting universidades...")
    print(upsert_many(universidades, "id_uni", universidades_data))

    print("Upserting uni_carreras...")
    uni_ids = [u["id_uni"] for u in universidades_data]
    all_carr_ids = [c["id_carrera"] for c in carreras_docs]

    uni_carr_docs = []
    for idx, id_carrera in enumerate(all_carr_ids):
        # Asigna 3 universidades por carrera de forma distribuida
        u1 = uni_ids[idx % len(uni_ids)]
        u2 = uni_ids[(idx + 3) % len(uni_ids)]
        u3 = uni_ids[(idx + 6) % len(uni_ids)]
        for id_uni in {u1, u2, u3}:
            id_uc = f"UC_{id_uni}_{id_carrera}"
            uni_carr_docs.append({"id_uniCarrera": id_uc, "id_carrera": id_carrera, "id_uni": id_uni})

    print(upsert_many(uni_carreras, "id_uniCarrera", uni_carr_docs))
    print("Listo. Semilla cargada sin duplicados.")

if __name__ == "__main__":
    main()