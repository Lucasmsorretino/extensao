from fastapi import APIRouter, Depends
from sqlmodel import Session, select
from typing import List
from backend.auth import decode_access_token
from database.db import get_session
from models.aviso import Aviso

router = APIRouter(prefix="/avisos", tags=["Avisos"])

# Rota protegida para listar avisos
@router.get("/", response_model=List[Aviso])
def listar_avisos(
    session: Session = Depends(get_session),
    user_data=Depends(decode_access_token)
):
    avisos = session.exec(select(Aviso)).all()
    return avisos

# Rota protegida para criar aviso
@router.post("/", response_model=Aviso)
def criar_aviso(
    aviso: Aviso,
    session: Session = Depends(get_session),
    user_data=Depends(decode_access_token)
):
    session.add(aviso)
    session.commit()
    session.refresh(aviso)
    return aviso