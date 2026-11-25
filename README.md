# BLM4587 Dönem Projesi

## Proje Hakkında

Bu proje, BLM4587 iOS ile Mobil Uygulama Geliştirme I dersi için geliştirilen **Rutin Ağı** alışkanlık takip asistanıdır. Flutter mobil uygulaması (`mobile`) ve Python FastAPI servisi (`api`) aynı depoda durur. Hedef platform Android’dir.

Şu an 4. hafta tamamlanmıştır.

- **API (`api`)**: PostgreSQL bağlantısı, SQLAlchemy modelleri (`User`, `Category`, `Habit`, `DailyLog`, `Reminder`) ve iki Alembic migration'ı kuruludur. Alışkanlıklar ve kategoriler için tam CRUD, günlük kayıt ve zincir (streak) uçları Swagger'da denenebilir.
- **Mobil (`mobile`)**: Flutter arayüz iskeleti, sayfa yönlendirmeleri (navigation) ve UI/UX şablonu hazırdır. Ekranlar örnek verilerle çalışır, henüz API'ye bağlı değildir. Giriş ekranı şimdilik kontrolsüz geçer.

### Dönem projesi videoları ve proje planı için [tıklayınız](https://drive.google.com/drive/folders/1Ut3m9OrrErO2O-cysbl3OEHaiOzV2-6A?usp=sharing)

## Özellikler

### API

- **API kök adresi** (`GET /`): servisin çalıştığını doğrular.
- **Sağlık ucu** (`GET /health`): servisin ayakta olduğunu bildirir.
- Oluşturulan tablolar: Users, Categories, Habits, DailyLogs, Reminders. Roller: Admin ve Member.
- **Kategoriler** (`GET /categories`, `POST /categories`, `GET /categories/tree`, `PUT /categories/{id}`, `DELETE /categories/{id}`): listeleme, ekleme, ağaç görünümü, güncelleme ve silme.
- **Alışkanlıklar** (`GET /habits`, `GET /habits/{id}`, `POST /habits`, `PUT /habits/{id}`, `DELETE /habits/{id}`): tam CRUD. Alışkanlık döngüsü alanları: işaret (`cue`), çekici kılma (`attraction`), kolaylaştırma (`easy_step`), ödül (`reward`).
- **Günlük kayıt ve zincir** (`POST /habits/{id}/logs`, `GET /habits/{id}/logs`, `GET /habits/{id}/streak`): aynı güne tek kayıt, ardışık tamamlanan gün sayısı.
- **Kullanıcı oluşturma** (`POST /users`): şifre Argon2 ile özetlenerek saklanır.

### Mobil

- **Ekranlar**: açılış, giriş, kayıt, alışkanlık listesi, alışkanlık detayı, alışkanlık formu (ekleme ve düzenleme), profil ve kategori yönetimi (Admin).
- **Yönlendirme**: sayfa adresleri `lib/core/routes.dart` içinde, rota tablosu `lib/app.dart` içindedir. Ana sayfada Alışkanlıklar ve Profil sekmeli alt menü bulunur.
- **UI/UX şablonu**: ortak renkler ve tema `lib/core/theme` altındadır, tekrar kullanılan parçalar `lib/widgets` altındadır.
- Ekranlar `lib/features` altında özelliğe göre gruplanmıştır: `splash`, `auth`, `shell`, `habits`, `profile`, `admin`.

## Çalıştırma Talimatları

Python 3.12, `uv`, PostgreSQL ve Flutter SDK kurulu olmalıdır. Flutter sürümü Dart 3.11.5 veya üstünü içermelidir (`mobile/pubspec.yaml`).

API’yi başlatmak için (ilk kurulumda PostgreSQL'de veritabanı ve kullanıcı oluşturun, `api/.env.example` dosyasını `api/.env` olarak kopyalayıp bağlantı bilgilerini yazın):

```bash
cd api
uv sync
uv run alembic upgrade head
uv run uvicorn app.main:app --reload
```

Tarayıcıda şu adreslere gidin:

- API: http://127.0.0.1:8000
- Swagger: http://127.0.0.1:8000/docs

Mobil uygulamayı başlatmak için:

```bash
cd mobile
flutter pub get
flutter run
```

Mobil uygulama şu an API'ye bağlanmaz, bu yüzden API adresi ayarı gerekmez. API bağlantısı eklendiğinde adresin nasıl ayarlanacağı bu bölüme yazılacaktır.
