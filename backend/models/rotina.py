from pydantic import BaseModel
from datetime import datetime

class Rotina(BaseModel):
    id: int
    usuario_id: int
    data: datetime
    descricao: str