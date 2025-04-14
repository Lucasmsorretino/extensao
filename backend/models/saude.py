from pydantic import BaseModel
from datetime import datetime

class Saude(BaseModel):
    id: int
    usuario_id: int
    tipo: str
    descricao: str
    data: datetime