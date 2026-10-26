# BLM4587 Dönem Projesi

## Proje Hakkında

Bu proje, BLM4587 iOS ile Mobil Uygulama Geliştirme I dersi için geliştirilen **Rutin Ağı** alışkanlık takip asistanıdır. Flutter mobil uygulaması (`mobile`) ve Python FastAPI servisi (`api`) aynı depoda durur. Hedef platform Android’dir.

Şu an 1. hafta iskeleti kuruludur. Flutter kurulumu tamamlanmış, Dart tarafında `const`, `final`, `?`, `$` ve `${}` ifadeleri denenmiştir. API kök adresi uygulamanın ayağa kalktığını bildirir. Veriler henüz veritabanına yazılmaz.

### Dönem projesi videoları ve proje planı için [tıklayınız](https://drive.google.com/drive/folders/1Ut3m9OrrErO2O-cysbl3OEHaiOzV2-6A?usp=sharing)

## Özellikler

- **Mobil kurulum ekranı**: uygulama açıldığında Flutter ve Dart kurulumunun tamamlandığını gösterir.
- **Dart temelleri**: `Aliskanlik` sınıfında `const`, `final`, nullable `String?`, `$` ile metin birleştirme ve `${}` ile ifade yerleştirme denenmiştir.
- **API kök adresi** (`GET /`): servisin çalıştığını doğrular.
- Planlanan tablolar: Users, Habits, Categories, DailyLogs, Reminders. Roller: Admin ve Member.

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

API’yi başlatmak için:

```bash
cd api
uv run uvicorn main:app --reload
```

Tarayıcıda şu adrese gidin:

- API: http://127.0.0.1:8000
