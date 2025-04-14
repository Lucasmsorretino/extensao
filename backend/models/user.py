from pydantic import BaseModel

class User(BaseModel):
    id: int
    nome: str
    email: str
    senha: str
    tipo: str  # 'responsavel' ou 'funcionario'
