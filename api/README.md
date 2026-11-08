# Rutin Ağı API

FastAPI + PostgreSQL ile yazılmış arka uç.

## Kurulum

1. PostgreSQL'de veritabanı ve kullanıcı oluştur.
2. `api/.env.example` dosyasını `api/.env` olarak kopyala ve şifreni yaz.
3. Bağımlılıkları kur:

       cd api
       uv sync

## Çalıştırma

    cd api
    uv run uvicorn app.main:app --reload

Swagger arayüzü: http://127.0.0.1:8000/docs