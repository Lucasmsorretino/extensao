from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from sqlmodel import SQLModel, Field
from datetime import datetime
from typing import Optional



class Aviso(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    titulo: str
    mensagem: str
    data: datetime = Field(default_factory=datetime.utcnow)

class User(BaseModel):
    id: int
    nome: str
    email: str
    senha: str
    tipo: str  # 'responsavel' ou 'funcionario'

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
