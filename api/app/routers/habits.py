from datetime import date, timedelta

from fastapi import APIRouter, Depends, HTTPException, Response, status
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import Session

from app.db import get_db
from app.models.category import Category
from app.models.daily_log import DailyLog
from app.models.habit import Habit
from app.models.user import User
from app.schemas.habit import (
    DailyLogCreate,
    DailyLogRead,
    HabitCreate,
    HabitRead,
    HabitUpdate,
    StreakRead,
)

router = APIRouter(prefix="/habits", tags=["Alışkanlıklar"])


def get_habit_or_404(habit_id: int, db: Session) -> Habit:
    habit = db.get(Habit, habit_id)
    if habit is None:
        raise HTTPException(status_code=404, detail="Alışkanlık bulunamadı")
    return habit


def check_category(category_id: int | None, db: Session) -> None:
    if category_id is not None and db.get(Category, category_id) is None:
        raise HTTPException(status_code=404, detail="Kategori bulunamadı")


@router.get("", response_model=list[HabitRead])
def list_habits(user_id: int | None = None, db: Session = Depends(get_db)):
    query = select(Habit).order_by(Habit.id)
    if user_id is not None:
        query = query.where(Habit.user_id == user_id)
    return db.scalars(query).all()


@router.get("/{habit_id}", response_model=HabitRead)
def get_habit(habit_id: int, db: Session = Depends(get_db)):
    return get_habit_or_404(habit_id, db)


@router.post("", response_model=HabitRead, status_code=status.HTTP_201_CREATED)
def create_habit(data: HabitCreate, db: Session = Depends(get_db)):
    if db.get(User, data.user_id) is None:
        raise HTTPException(status_code=404, detail="Kullanıcı bulunamadı")
    check_category(data.category_id, db)
    habit = Habit(
        user_id=data.user_id,
        category_id=data.category_id,
        name=data.name,
        cue=data.cue,
        attraction=data.attraction,
        easy_step=data.easy_step,
        reward=data.reward,
        period=data.period,
        target_count=data.target_count,
        is_active=data.is_active,
    )
    db.add(habit)
    db.commit()
    db.refresh(habit)
    return habit


@router.put("/{habit_id}", response_model=HabitRead)
def update_habit(habit_id: int, data: HabitUpdate, db: Session = Depends(get_db)):
    habit = get_habit_or_404(habit_id, db)
    check_category(data.category_id, db)
    habit.category_id = data.category_id
    habit.name = data.name
    habit.cue = data.cue
    habit.attraction = data.attraction
    habit.easy_step = data.easy_step
    habit.reward = data.reward
    habit.period = data.period
    habit.target_count = data.target_count
    habit.is_active = data.is_active
    db.commit()
    db.refresh(habit)
    return habit


@router.delete("/{habit_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_habit(habit_id: int, db: Session = Depends(get_db)):
    habit = get_habit_or_404(habit_id, db)
    db.delete(habit)
    db.commit()
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@router.post(
    "/{habit_id}/logs",
    response_model=DailyLogRead,
    status_code=status.HTTP_201_CREATED,
)
def create_log(habit_id: int, data: DailyLogCreate, db: Session = Depends(get_db)):
    get_habit_or_404(habit_id, db)
    log = DailyLog(habit_id=habit_id, **data.model_dump())
    db.add(log)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="Bu gün için kayıt zaten var",
        )
    db.refresh(log)
    return log


@router.get("/{habit_id}/logs", response_model=list[DailyLogRead])
def list_logs(habit_id: int, db: Session = Depends(get_db)):
    get_habit_or_404(habit_id, db)
    query = (
        select(DailyLog)
        .where(DailyLog.habit_id == habit_id)
        .order_by(DailyLog.log_date.desc())
    )
    return db.scalars(query).all()


@router.get("/{habit_id}/streak", response_model=StreakRead)
def get_streak(habit_id: int, db: Session = Depends(get_db)):
    get_habit_or_404(habit_id, db)
    done_days = set(
        db.scalars(
            select(DailyLog.log_date).where(
                DailyLog.habit_id == habit_id, DailyLog.completed.is_(True)
            )
        ).all()
    )
    day = date.today()
    if day not in done_days:
        day -= timedelta(days=1)
    streak = 0
    while day in done_days:
        streak += 1
        day -= timedelta(days=1)
    return StreakRead(habit_id=habit_id, streak=streak)
