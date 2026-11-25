from datetime import date

from sqlalchemy import Boolean, Date, ForeignKey, String, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column

from app.db import Base # Bütün modellerin türediği temel sınıf

# Bire-çok ilişkide kural: Yabancı anahtar her zaman "çok" tarafındaki tabloya yazılır. 
# Bir alışkanlığın çok kaydı var, bu yüzden habit_id daily_logs tablosunda duruyor, habits tablosunda değil.

class DailyLog(Base):
    __tablename__ = "daily_logs"
    __table_args__ = (
        UniqueConstraint("habit_id", "log_date", name="uq_daily_logs_habit_date"),
    )

    id: Mapped[int] = mapped_column(primary_key=True)
    habit_id: Mapped[int] = mapped_column(
        ForeignKey("habits.id", ondelete="CASCADE"), index=True
    )
    log_date: Mapped[date] = mapped_column(Date)
    completed: Mapped[bool] = mapped_column(Boolean, default=True)
    note: Mapped[str | None] = mapped_column(String(255), nullable=True)

# Genel kalıp: SQLAlchemy 2.0'da her kolon isim: Mapped[tip] = mapped_column(ayarlar) biçiminde yazılır.