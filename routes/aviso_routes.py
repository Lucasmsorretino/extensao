from fastapi import APIRouter

router = APIRouter(prefix="/avisos", tags=["Avisos"])

@router.get("/")
def listar_avisos():
    return [{"titulo": "Reunião", "mensagem": "Reunião dia 10/04 às 18h."}]
