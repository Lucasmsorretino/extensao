#!/usr/bin/env python3
"""
Script para testar login e obter token válido
"""
import requests
import json
from datetime import datetime

def test_login():
    """Testa o login e retorna o token"""
    base_url = "http://localhost:8000"
    
    print("🔐 TESTE DE LOGIN")
    print("=" * 50)
    
    # Dados de login
    login_data = {
        "username": "lucas",
        "password": "senha123"
    }
    
    try:
        # Fazer requisição de login
        print(f"📡 Fazendo login em: {base_url}/token")
        print(f"👤 Username: {login_data['username']}")
        print(f"🔒 Password: {login_data['password']}")
        
        # Headers para form data
        headers = {
            "Content-Type": "application/x-www-form-urlencoded"
        }
        
        response = requests.post(
            f"{base_url}/token", 
            data=login_data,
            headers=headers
        )
        
        print(f"\n📊 Status da resposta: {response.status_code}")
        
        if response.status_code == 200:
            token_data = response.json()
            
            print("✅ LOGIN BEM-SUCEDIDO!")
            print("-" * 30)
            print(f"🎫 Access Token: {token_data.get('access_token', 'N/A')}")
            print(f"🎭 Token Type: {token_data.get('token_type', 'N/A')}")
            
            # Salvar token em arquivo para uso posterior
            with open('token.txt', 'w') as f:
                f.write(token_data.get('access_token', ''))
            print("💾 Token salvo em 'token.txt'")
            
            # Testar o token fazendo uma requisição autenticada
            print("\n🧪 TESTANDO TOKEN...")
            test_token(token_data.get('access_token'))
            
            return token_data.get('access_token')
            
        else:
            print("❌ ERRO NO LOGIN!")
            print(f"Código: {response.status_code}")
            print(f"Resposta: {response.text}")
            return None
            
    except requests.exceptions.ConnectionError:
        print("❌ ERRO: Não foi possível conectar ao backend!")
        print("Certifique-se de que o backend está rodando em localhost:8000")
        print("Execute: python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000")
        return None
    except Exception as e:
        print(f"❌ ERRO INESPERADO: {e}")
        return None

def test_token(token):
    """Testa se o token está funcionando"""
    if not token:
        print("❌ Token não fornecido")
        return False
        
    base_url = "http://localhost:8000"
    
    try:
        # Headers com autenticação
        headers = {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json"
        }
        
        # Testar endpoint de avisos (requer autenticação)
        response = requests.get(f"{base_url}/avisos", headers=headers)
        
        if response.status_code == 200:
            avisos = response.json()
            print(f"✅ Token válido! Encontrados {len(avisos)} avisos:")
            for i, aviso in enumerate(avisos[:3], 1):  # Mostrar apenas os 3 primeiros
                print(f"   {i}. {aviso.get('titulo', 'Sem título')}")
            return True
        else:
            print(f"❌ Token inválido! Status: {response.status_code}")
            print(f"Resposta: {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Erro ao testar token: {e}")
        return False

def show_curl_examples(token):
    """Mostra exemplos de como usar o token com curl"""
    print("\n📋 EXEMPLOS DE USO COM CURL:")
    print("-" * 40)
    print(f"""
# Listar avisos
curl -H "Authorization: Bearer {token[:20]}..." http://localhost:8000/avisos

# Criar novo aviso
curl -X POST -H "Authorization: Bearer {token[:20]}..." \\
     -H "Content-Type: application/json" \\
     -d '{{"titulo": "Novo Aviso", "conteudo": "Conteúdo do aviso", "tipo": "geral"}}' \\
     http://localhost:8000/avisos

# Ver documentação da API
curl http://localhost:8000/docs
""")

if __name__ == "__main__":
    print(f"⏰ Executado em: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    token = test_login()
    
    if token:
        show_curl_examples(token)
        print("\n🎉 LOGIN COMPLETO!")
        print("💡 Use o token acima para fazer requisições autenticadas")
    else:
        print("\n❌ FALHA NO LOGIN!")
        print("Verifique se o backend está rodando e as credenciais estão corretas")
