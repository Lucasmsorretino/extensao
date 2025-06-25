import requests
import json

def test_backend_connection():
    """Testa a conexão com o backend e o login"""
    base_url = "http://localhost:8000"
    
    print("🔍 Testando conexão com o backend...")
    
    # 1. Testar saúde do backend
    try:
        response = requests.get(f"{base_url}/health", timeout=5)
        print(f"✅ Health Check: {response.status_code} - {response.text}")
    except Exception as e:
        print(f"❌ Health Check falhou: {e}")
        return False
    
    # 2. Testar login
    print("\n🔐 Testando login...")
    login_data = {
        "username": "lucas",
        "password": "senha123"
    }
    
    try:
        response = requests.post(
            f"{base_url}/token",
            data=login_data,  # FastAPI espera form-data para OAuth2
            timeout=5
        )
        
        if response.status_code == 200:
            token_data = response.json()
            print(f"✅ Login bem-sucedido!")
            print(f"🎫 Token: {token_data.get('access_token', 'N/A')[:50]}...")
            print(f"🎭 Token Type: {token_data.get('token_type', 'N/A')}")
            return True
        else:
            print(f"❌ Login falhou: {response.status_code}")
            print(f"📝 Resposta: {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Erro no login: {e}")
        return False

def test_avisos_endpoint():
    """Testa o endpoint de avisos"""
    print("\n📢 Testando endpoint de avisos...")
    
    try:
        response = requests.get("http://localhost:8000/avisos", timeout=5)
        
        if response.status_code == 200:
            avisos = response.json()
            print(f"✅ Avisos carregados: {len(avisos)} avisos encontrados")
            for i, aviso in enumerate(avisos[:3]):  # Mostrar apenas os primeiros 3
                print(f"   {i+1}. {aviso.get('title', 'N/A')}")
            return True
        else:
            print(f"❌ Erro ao carregar avisos: {response.status_code}")
            print(f"📝 Resposta: {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Erro ao testar avisos: {e}")
        return False

if __name__ == "__main__":
    print("🚀 TESTE DE CONECTIVIDADE BACKEND\n")
    
    backend_ok = test_backend_connection()
    avisos_ok = test_avisos_endpoint()
    
    print(f"\n📊 RESULTADO:")
    print(f"Backend: {'✅ OK' if backend_ok else '❌ FALHA'}")
    print(f"Avisos: {'✅ OK' if avisos_ok else '❌ FALHA'}")
    
    if backend_ok and avisos_ok:
        print("\n🎉 Backend está funcionando perfeitamente!")
        print("🔗 Use estas URLs para testar:")
        print("   - Documentação: http://localhost:8000/docs")
        print("   - Avisos: http://localhost:8000/avisos")
        print("   - Login: POST http://localhost:8000/token")
    else:
        print("\n⚠️ Há problemas na conectividade do backend.")
