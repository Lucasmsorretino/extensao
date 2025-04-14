from fastapi import APIRouter
from backend.auth import decode_access_token
from fastapi import Depends
from models.calendario import Calendario

router = APIRouter(prefix="/calendario", tags=["Calendário"])

@router.get("/")
def listar_eventos(user_data=Depends(decode_access_token)):
    return [{"tipo": "feriado", "data": "2025-04-21", "descricao": "Tiradentes"}]