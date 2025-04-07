from fastapi import APIRouter

router = APIRouter(prefix="/rotina", tags=["Rotina"])

@router.get("/")
def listar_rotina():
    return [{"data": "2025-04-06", "descricao": "Almoçou e dormiu após o almoço."}]
