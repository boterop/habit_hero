import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class APIService {
  final apiUrl = dotenv.env['API_URL'];
  final headers = {
    'Api-Key': 'Bearer ${dotenv.env['API_KEY']}',
    'Content-Type': 'application/json'
  };

  Future<String> login({required String user, required String password}) async {
    final uri = Uri.parse('$apiUrl/login');
    final response = await http.post(
      uri,
      headers: headers,
      body: {'user': user, 'password': password},
    );

    return response.statusCode == 200 ? jsonDecode(response.body) : ":error";
  }

  Future<String> register({
    required String email,
    required String user,
    required String password,
  }) async {
    final uri = Uri.parse('$apiUrl/register');
    final response = await http.post(
      uri,
      headers: headers,
      body: {'email': email, 'user': user, 'password': password},
    );

    return response.statusCode == 200 ? jsonDecode(response.body) : ":error";
  }

  Future<String> getHabitsList({required String userToken}) async {
    final uri = Uri.parse('$apiUrl/register');
    headers['Authorization'] = userToken;
    final response = await http.get(
      uri,
      headers: headers,
    );

    return response.statusCode == 200 ? jsonDecode(response.body) : ":error";
  }
}
