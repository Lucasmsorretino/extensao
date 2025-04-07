from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class User(BaseModel):
    id: int
    nome: str
    email: str
    senha: str
    tipo: str  # 'responsavel' ou 'funcionario'

class Aviso(BaseModel):
    id: int
    titulo: str
    mensagem: str
    data: datetime

class Rotina(BaseModel):
    id: int
    usuario_id: int
    data: datetime
    descricao: str

class Saude(BaseModel):
    id: int
    usuario_id: int
    tipo: str
    descricao: str
    data: datetime

class Calendario(BaseModel):
    id: int
    tipo: str
    data: datetime
    descricao: Optional[str] = None
