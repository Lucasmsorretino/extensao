from fastapi import FastAPI
from routes import token_routes, aviso_routes, rotina_routes, saude_routes, calendario_routes
from database.db import create_db_and_tables

@app.on_event("startup")
def on_startup():
    create_db_and_tables()

app = FastAPI(title="CMEI App API")

# Inclusão de rotas
app.include_router(user_routes.router)
app.include_router(aviso_routes.router)
app.include_router(rotina_routes.router)
app.include_router(saude_routes.router)
app.include_router(calendario_routes.router)
app.include_router(token_routes.router)

