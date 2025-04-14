import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/routine_model.dart';

class RoutineService {
  final String baseUrl;
  final String authToken;

  RoutineService({required this.baseUrl, required this.authToken});

  Future<bool> submitRoutine(RoutineModel routine) async {
    final url = Uri.parse('$baseUrl/rotina');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(routine.toJson()),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
