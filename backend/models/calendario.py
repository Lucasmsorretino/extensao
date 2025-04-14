from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class Calendario(BaseModel):
    id: int
    tipo: str
    data: datetime
    descricao: Optional[str] = None