from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.models.category import Category
from app.schemas.category import CategoryCreate, CategoryRead, CategoryTree

router = APIRouter(prefix="/categories", tags=["Kategoriler"])


@router.get("", response_model=list[CategoryRead])
def list_categories(db: Session = Depends(get_db)):
    return db.scalars(select(Category).order_by(Category.id)).all()


@router.post("", response_model=CategoryRead, status_code=status.HTTP_201_CREATED)
def create_category(data: CategoryCreate, db: Session = Depends(get_db)):
    if data.parent_id is not None and db.get(Category, data.parent_id) is None:
        raise HTTPException(status_code=404, detail="Üst kategori bulunamadı")
    category = Category(name=data.name, parent_id=data.parent_id)
    db.add(category)
    db.commit()
    db.refresh(category)
    return category


@router.get("/tree", response_model=list[CategoryTree])
def category_tree(db: Session = Depends(get_db)):
    categories = db.scalars(select(Category).order_by(Category.id)).all()
    nodes = {c.id: {"id": c.id, "name": c.name, "children": []} for c in categories}
    roots = []
    for c in categories:
        if c.parent_id is None:
            roots.append(nodes[c.id])
        else:
            nodes[c.parent_id]["children"].append(nodes[c.id])
    return roots