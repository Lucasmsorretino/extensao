from sqlmodel import SQLModel, Field
from datetime import datetime
from typing import Optional

class Aviso(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    titulo: str
    mensagem: str
    data: datetime = Field(default_factory=datetime.utcnow)
