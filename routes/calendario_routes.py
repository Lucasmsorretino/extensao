from fastapi import APIRouter

router = APIRouter(prefix="/calendario", tags=["Calendário"])

@router.get("/")
def listar_eventos():
    return [{"tipo": "feriado", "data": "2025-04-21", "descricao": "Tiradentes"}]
