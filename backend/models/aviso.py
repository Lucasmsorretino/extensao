from sqlmodel import SQLModel, Field, Relationship
from typing import Optional, List
from datetime import datetime


class Aviso(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    title: str
    content: str
    created_at: datetime = Field(default_factory=datetime.now)
    updated_at: Optional[datetime] = None
    author_id: int = Field(foreign_key="user.id")
    
    # Specific classes or for everyone 
    target_classroom: Optional[str] = None  # If None, for all classrooms
    
    # Relationships
    author: User = Relationship(back_populates="avisos")