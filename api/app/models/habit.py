import enum
from datetime import datetime

from sqlalchemy import Boolean, DateTime, Enum, ForeignKey, Integer, String, func
from sqlalchemy.orm import Mapped, mapped_column

from app.db import Base


class HabitPeriod(str, enum.Enum):
    DAILY = "Daily"
    WEEKLY = "Weekly"


class Habit(Base):
    __tablename__ = "habits"

    id: Mapped[int] = mapped_column(primary_key=True)
    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True
    )
    category_id: Mapped[int | None] = mapped_column(
        ForeignKey("categories.id", ondelete="SET NULL"), nullable=True
    )
    name: Mapped[str] = mapped_column(String(100))
    cue: Mapped[str | None] = mapped_column(String(255), nullable=True)
    attraction: Mapped[str | None] = mapped_column(String(255), nullable=True)
    easy_step: Mapped[str | None] = mapped_column(String(255), nullable=True)
    reward: Mapped[str | None] = mapped_column(String(255), nullable=True)
    period: Mapped[HabitPeriod] = mapped_column(
        Enum(
            HabitPeriod,
            native_enum=False,
            length=20,
            values_callable=lambda e: [m.value for m in e],
        ),
        default=HabitPeriod.DAILY,
    )
    target_count: Mapped[int] = mapped_column(Integer, default=1)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now()
    )
