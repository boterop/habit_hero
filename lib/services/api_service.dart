import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class APIService {
  final apiUrl = dotenv.env['API_URL'];
  final headers = {
    'Api-Key': 'Bearer ${dotenv.env['API_KEY']}',
    'Content-Type': 'application/json'
  };

  Future<bool> health() async {
    final uri = Uri.parse('$apiUrl/health');
    final response = await http.get(uri, headers: headers);
    return response.statusCode == 200;
  }

  Future<Map> signIn({required String email, required String password}) async {
    final uri = Uri.parse('$apiUrl/sign_in');
    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({'email': email, 'password': password}),
    );

    return jsonDecode(response.body);
  }

  Future<String> signUp({
    required String email,
    required String user,
    required String password,
  }) async {
    final uri = Uri.parse('$apiUrl/sign_up');
    final response = await http.post(
      uri,
      headers: headers,
      body: {'email': email, 'user': user, 'password': password},
    );

    return response.statusCode == 201
        ? jsonDecode(response.body)
        : "${response.statusCode}: ${response.body}";
  }

  Future<Map> getHabitsList({required String userToken}) async {
    final uri = Uri.parse('$apiUrl/habits');
    headers['Authorization'] = userToken;
    final response = await http.get(uri, headers: headers);

    return jsonDecode(response.body);
  }
}
