from fastapi import APIRouter, Depends
from pydantic import BaseModel
from typing import List
from datetime import datetime
from auth import decode_access_token

router = APIRouter(prefix="/avisos", tags=["Avisos"])

# Banco de dados fake (em memória)
avisos_db = []

# Modelo do aviso
class Aviso(BaseModel):
    titulo: str
    mensagem: str
    data: datetime = datetime.now()

# Rota protegida para listar avisos
@router.get("/", response_model=List[Aviso])
def listar_avisos(user_data=Depends(decode_access_token)):
    return avisos_db

# Rota protegida para criar aviso
@router.post("/", response_model=Aviso)
def criar_aviso(aviso: Aviso, user_data=Depends(decode_access_token)):
    avisos_db.append(aviso)
    return aviso