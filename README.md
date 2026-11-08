# BLM4587 Dönem Projesi

## Proje Hakkında

Bu proje, BLM4587 iOS ile Mobil Uygulama Geliştirme I dersi için geliştirilen **Rutin Ağı** alışkanlık takip asistanıdır. Flutter mobil uygulaması (`mobile`) ve Python FastAPI servisi (`api`) aynı depoda durur. Hedef platform Android’dir.

Şu an 2. hafta tamamlanmıştır. API tarafında PostgreSQL bağlantısı, SQLAlchemy modelleri (`User`, `Category`) ve ilk Alembic migration'ı kuruludur. Kategori ve kullanıcı uçları Swagger'da denenebilir. Flutter kurulumu tamamlanmış, Dart tarafında `const`, `final`, `?`, `$` ve `${}` ifadeleri denenmiştir.

### Dönem projesi videoları ve proje planı için [tıklayınız](https://drive.google.com/drive/folders/1Ut3m9OrrErO2O-cysbl3OEHaiOzV2-6A?usp=sharing)

## Özellikler

- **Mobil kurulum ekranı**: uygulama açıldığında Flutter ve Dart kurulumunun tamamlandığını gösterir.
- **Dart temelleri**: `Aliskanlik` sınıfında `const`, `final`, nullable `String?`, `$` ile metin birleştirme ve `${}` ile ifade yerleştirme denenmiştir.
- **API kök adresi** (`GET /`): servisin çalıştığını doğrular.
- Oluşturulan tablolar: Users, Categories. Planlanan tablolar: Habits, DailyLogs, Reminders. Roller: Admin ve Member.
- **Sağlık ucu** (`GET /health`): servisin ayakta olduğunu bildirir.
- **Kategoriler** (`GET /categories`, `POST /categories`, `GET /categories/tree`): listeleme, ekleme ve ağaç görünümü.
- **Kullanıcı oluşturma** (`POST /users`): şifre Argon2 ile özetlenerek saklanır.
## Model



`Aliskanlik` modeli şu alanları içerir:

| Alan | Açıklama |
| --- | --- |
| `ad` | Alışkanlık adı (`final String`, zorunlu) |
| `streak` | Üst üste tamamlanan gün sayısı (`int`, varsayılan 0) |
| `aciklama` | Açıklama (`String?`, boş olabilir) |

## Çalıştırma Talimatları

Flutter SDK ve Python 3.12 kurulu olmalıdır.

Mobil uygulamayı başlatmak için:

```bash
cd mobile
flutter pub get
flutter run
```

API’yi başlatmak için (ilk kurulumda `api/.env.example` dosyasını `api/.env` olarak kopyalayıp bağlantı bilgilerini yazın):

```bash
cd api
uv run uvicorn app.main:app --reload
```

Tarayıcıda şu adreslere gidin:

- API: http://127.0.0.1:8000
- Swagger: http://127.0.0.1:8000/docs
