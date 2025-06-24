# 🚀 GUIA DE REQUISIÇÕES PARA TESTE DE API

## 📝 **Como Fazer Login e Obter Token**

### **1. Login (POST /token)**
```
URL: http://localhost:8000/token
Method: POST
Content-Type: application/x-www-form-urlencoded

Body (form-data):
username: lucas
password: senha123
```

**Resposta esperada:**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "token_type": "bearer"
}
```

### **2. Testar Token (GET /avisos)**
```
URL: http://localhost:8000/avisos
Method: GET
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
```

## 🧪 **Exemplos de CURL**

### **Login:**
```bash
curl -X POST "http://localhost:8000/token" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "username=lucas&password=senha123"
```

### **Listar Avisos (com token):**
```bash
curl -H "Authorization: Bearer SEU_TOKEN_AQUI" \
     http://localhost:8000/avisos
```

### **Criar Novo Aviso:**
```bash
curl -X POST "http://localhost:8000/avisos" \
     -H "Authorization: Bearer SEU_TOKEN_AQUI" \
     -H "Content-Type: application/json" \
     -d '{
       "titulo": "Novo Aviso",
       "conteudo": "Conteúdo do aviso",
       "tipo": "geral",
       "data_inicio": "2025-06-24",
       "data_fim": "2025-06-30"
     }'
```

## 🎯 **Token Atual Válido:**
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJsdWNhcyIsImV4cCI6MTc1MDc5ODQzNH0.4W3a1aoBpB9kA1U1SquqPYqde0LQ4VWFoKAVaGpcsRY
```

## 📋 **Credenciais do Usuário de Teste:**
- **Username:** lucas
- **Password:** senha123
- **Email:** lucas@test.com

## 🔧 **Como Usar no Device Preview:**

1. **Abra o Device Preview** (que já está rodando)
2. **Na tela de login, digite:**
   - Username: `lucas`
   - Password: `senha123`
3. **Clique em "Login"**
4. **O token será armazenado automaticamente**

## 🛠️ **Renovar Token:**

Se o token expirar, simpemente faça login novamente:
- Via Device Preview: Logout → Login
- Via Script: Execute `python test_login.py`
- Via API: Faça nova requisição POST para `/token`

## 🎨 **Endpoints Disponíveis:**

- `GET /health` - Verificar saúde da API
- `POST /token` - Login e obter token
- `GET /avisos` - Listar avisos (requer auth)
- `POST /avisos` - Criar aviso (requer auth)
- `PUT /avisos/{id}` - Atualizar aviso (requer auth)
- `DELETE /avisos/{id}` - Deletar aviso (requer auth)
- `GET /docs` - Documentação interativa da API
