from datetime import date, datetime

from pydantic import BaseModel, ConfigDict, Field

from app.models.habit import HabitPeriod


class HabitBase(BaseModel):
    name: str = Field(min_length=1, max_length=100)
    category_id: int | None = None
    cue: str | None = Field(default=None, max_length=255)
    attraction: str | None = Field(default=None, max_length=255)
    easy_step: str | None = Field(default=None, max_length=255)
    reward: str | None = Field(default=None, max_length=255)
    period: HabitPeriod = HabitPeriod.DAILY
    target_count: int = Field(default=1, ge=1, le=100)
    is_active: bool = True


class HabitCreate(HabitBase):
    user_id: int


class HabitUpdate(HabitBase):
    pass


class HabitRead(HabitBase):
    model_config = ConfigDict(from_attributes=True)

    id: int
    user_id: int
    created_at: datetime


class DailyLogCreate(BaseModel):
    log_date: date = Field(default_factory=date.today)
    completed: bool = True
    note: str | None = Field(default=None, max_length=255)


class DailyLogRead(DailyLogCreate):
    model_config = ConfigDict(from_attributes=True)

    id: int
    habit_id: int


class StreakRead(BaseModel):
    habit_id: int
    streak: int
