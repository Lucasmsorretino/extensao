from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from datetime import timedelta
from backend.auth import verify_password, create_access_token, ACCESS_TOKEN_EXPIRE_MINUTES

router = APIRouter(tags=["Autenticação"])

# Usuário fake de exemplo (substituir por banco de dados futuramente)
fake_user = {
    "username": "lucas",
    "hashed_password": "$2b$12$vETJK7ULfRFX2bTiiHCrP.FGbiyp70YMrVXQGySvp9Pt/rs35jjyK"  # senha123
}

@router.post("/token")
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    username = form_data.username
    password = form_data.password

    if username != fake_user["username"] or not verify_password(password, fake_user["hashed_password"]):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Usuário ou senha incorretos")

    access_token = create_access_token(data={"sub": username}, expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    return {"access_token": access_token, "token_type": "bearer"}
