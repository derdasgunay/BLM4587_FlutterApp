from fastapi import APIRouter, Depends, HTTPException, Response, status
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.models.category import Category
from app.schemas.category import CategoryCreate, CategoryRead, CategoryTree

router = APIRouter(prefix="/categories", tags=["Kategoriler"])


def get_category_or_404(category_id: int, db: Session) -> Category:
    category = db.get(Category, category_id)
    if category is None:
        raise HTTPException(status_code=404, detail="Kategori bulunamadı")
    return category


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
    query = select(Category).order_by(Category.id)
    categories = db.scalars(query).all()

    nodes = {}
    for category in categories:
        node = {
            "id": category.id,
            "name": category.name,
            "children": [],
        }
        nodes[category.id] = node

    roots = []
    for category in categories:
        node = nodes[category.id]
        if category.parent_id is None:
            roots.append(node)
        else:
            parent_node = nodes[category.parent_id]
            parent_node["children"].append(node)

    return roots


@router.put("/{category_id}", response_model=CategoryRead)
def update_category(
    category_id: int, data: CategoryCreate, db: Session = Depends(get_db)
):
    category = get_category_or_404(category_id, db)
    parent_id = data.parent_id
    while parent_id is not None:
        if parent_id == category_id:
            raise HTTPException(
                status_code=400, detail="Kategori kendi altına taşınamaz"
            )
        parent_id = get_category_or_404(parent_id, db).parent_id
    category.name = data.name
    category.parent_id = data.parent_id
    db.commit()
    db.refresh(category)
    return category


@router.delete("/{category_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_category(category_id: int, db: Session = Depends(get_db)):
    category = get_category_or_404(category_id, db)
    has_child = db.scalar(select(Category.id).where(Category.parent_id == category_id))
    if has_child is not None:
        raise HTTPException(
            status_code=409, detail="Önce alt kategorileri silin ya da taşıyın"
        )
    db.delete(category)
    db.commit()
    return Response(status_code=status.HTTP_204_NO_CONTENT)
