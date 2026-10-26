from fastapi import FastAPI

app = FastAPI(title="Rutin Ağı API")

@app.get("/")
def read_root():
    return {"Sistem Kuruldu"}