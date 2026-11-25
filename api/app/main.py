from fastapi import FastAPI
from app.routers import categories, habits, users

app = FastAPI(title="Rutin Ağı API")
app.include_router(categories.router)
app.include_router(users.router)
app.include_router(habits.router)

@app.get("/")
def read_root():
    return {"durum" : "Sistem kuruldu"}

@app.get("/health")
def health():
    return {"durum": "ok"}
