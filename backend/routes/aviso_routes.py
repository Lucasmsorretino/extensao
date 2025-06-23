from fastapi import APIRouter, Depends, HTTPException, status
from sqlmodel import Session, select
from typing import List
from database.session import get_session
from models.aviso import Aviso
from models.user import User
from datetime import datetime
from auth import decode_access_token

router = APIRouter(prefix="/avisos", tags=["avisos"])

def get_current_user():
    pass  # Implement this function to get the current user


@router.post("/", response_model=Aviso)
def create_aviso(
    aviso_data: Aviso, 
    session: Session = Depends(get_session),
    current_user: User = Depends(get_current_user)  # You'll need to implement this in auth.py
):
    aviso = Aviso(
        title=aviso_data.title,
        content=aviso_data.content,
        target_classroom=aviso_data.target_classroom,
        author_id=current_user.id
    )
    session.add(aviso)
    session.commit()
    session.refresh(aviso)
    return aviso

@router.get("/", response_model=List[Aviso])
def read_avisos(
    skip: int = 0, 
    limit: int = 100,
    session: Session = Depends(get_session),
    current_user: User = Depends(get_current_user)
):
    statement = select(Aviso).offset(skip).limit(limit)
    avisos = session.exec(statement).all()
    return avisos

@router.get("/{aviso_id}", response_model=Aviso)
def read_aviso(
    aviso_id: int, 
    session: Session = Depends(get_session)
):
    aviso = session.get(Aviso, aviso_id)
    if not aviso:
        raise HTTPException(status_code=404, detail="Aviso not found")
    return aviso

@router.put("/{aviso_id}", response_model=Aviso)
def update_aviso(
    aviso_id: int,
    aviso_data: Aviso,
    session: Session = Depends(get_session),
    current_user: User = Depends(get_current_user)
):
    aviso = session.get(Aviso, aviso_id)
    if not aviso:
        raise HTTPException(status_code=404, detail="Aviso not found")
    
    # Check if current user is the author or admin
    if aviso.author_id != current_user.id and current_user.user_type != "admin":
        raise HTTPException(status_code=403, detail="Not authorized to update this aviso")
    
    # Update fields
    aviso_data_dict = aviso_data.dict(exclude_unset=True)
    for key, value in aviso_data_dict.items():
        if key != "id" and key != "author_id" and key != "created_at":
            setattr(aviso, key, value)
    
    aviso.updated_at = datetime.now()
    session.add(aviso)
    session.commit()
    session.refresh(aviso)
    return aviso

@router.delete("/{aviso_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_aviso(
    aviso_id: int,
    session: Session = Depends(get_session),
    current_user: User = Depends(get_current_user)
):
    aviso = session.get(Aviso, aviso_id)
    if not aviso:
        raise HTTPException(status_code=404, detail="Aviso not found")
        
    # Check if current user is the author or admin
    if aviso.author_id != current_user.id and current_user.user_type != "admin":
        raise HTTPException(status_code=403, detail="Not authorized to delete this aviso")
    
    session.delete(aviso)
    session.commit()
    return None