from fastapi import APIRouter

router = APIRouter(prefix="/login", tags=["Login"])

@router.get("/")
def login_exemplo():
    return {"message": "Endpoint de login"}
