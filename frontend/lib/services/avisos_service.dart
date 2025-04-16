import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/aviso.dart';

class AvisosService {
  final String baseUrl = 'http://localhost:8000';
  final _storage = FlutterSecureStorage();
  
  Future<List<Aviso>> getAvisos() async {
    final token = await _storage.read(key: 'token');
    
    if (token == null) {
      throw Exception('Usuário não autenticado');
    }
    
    final response = await http.get(
      Uri.parse('$baseUrl/avisos'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Aviso.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar avisos: ${response.statusCode}');
    }
  }
  
  // Add more methods for creating, updating, and deleting avisos
}