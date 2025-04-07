from fastapi import APIRouter

router = APIRouter(prefix="/saude", tags=["Saúde"])

@router.get("/")
def listar_saude():
    return [{"tipo": "medicamento", "descricao": "Paracetamol 10ml às 14h"}]
