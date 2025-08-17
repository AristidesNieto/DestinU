# main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import area, carreras, universidad, usuario, uni_carrera_usuario

app = FastAPI(title="Career API (ERD-aligned)")

# Configuración CORS
origins = ["*"]  # Cambiar por el dominio de tu app en producción
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Registro de routers
app.include_router(area.router)
app.include_router(carreras.router)
app.include_router(universidad.router)
app.include_router(usuario.router)
app.include_router(uni_carrera_usuario.router)

# Endpoint de prueba
@app.get("/")
def read_root():
    return {"mensaje": "API funcionando correctamente"}