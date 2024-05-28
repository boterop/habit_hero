import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:habit_hero/services/user_service.dart';
import 'package:http/http.dart' as http;

class APIService {
  final apiUrl = dotenv.env['API_URL'];
  final _headers = {
    'Api-Key': 'Bearer ${dotenv.env['API_KEY']}',
    'Authentication': 'Bearer ${UserService.instance.session}',
    'Language': Platform.localeName,
    'Content-Type': 'application/json'
  };

  Map<String, String> get headers => _headers;

  Future<bool> health() async {
    final uri = Uri.parse('$apiUrl/health');
    final response = await http.get(uri, headers: _headers).timeout(
        const Duration(seconds: 3),
        onTimeout: () => http.Response('Error', 408));
    return response.statusCode == 200;
  }

  Future<Map> signIn({required String email, required String password}) async {
    final uri = Uri.parse('$apiUrl/sign-in');
    final response = await http.post(
      uri,
      headers: _headers,
      body: jsonEncode({'email': email, 'password': password}),
    );

    return jsonDecode(response.body);
  }

  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$apiUrl/sign-up');
    final response = await http.post(
      uri,
      headers: _headers,
      body: {'email': email, 'password': password},
    );

    return response.statusCode == 201
        ? jsonDecode(response.body)
        : "${response.statusCode}: ${response.body}";
  }

  Future<Map> createHabit({
    required String type,
    required String name,
    required String description,
    required String notify,
    required DateTime endDate,
  }) async {
    final uri = Uri.parse('$apiUrl/habits');
    final response = await http.post(
      uri,
      headers: _headers,
      body: jsonEncode({
        'habit': {
          'type': type,
          'name': name,
          'description': description,
          'difficulty': "easy",
          'notification_date': DateTime.now().toIso8601String(),
          'notify': notify,
          'end_date': endDate.toIso8601String(),
          'user_id': UserService.instance.id,
        }
      }),
    );

    return jsonDecode(response.body);
  }

  Future<Map> updateHabit(Map<String, dynamic> opts) async {
    opts = opts.map((key, value) {
      if (value is DateTime) return MapEntry(key, value.toIso8601String());
      return MapEntry(key, value);
    });
    final uri = Uri.parse('$apiUrl/habits/${opts["id"]}');
    final response = await http.put(
      uri,
      headers: _headers,
      body: jsonEncode({'habit': opts}),
    );

    return jsonDecode(response.body);
  }

  Future<bool> deleteHabit({required String id}) async {
    final uri = Uri.parse('$apiUrl/habits/$id');
    final response = await http.delete(uri, headers: _headers);

    return response.statusCode == 204;
  }

  Future<Map> getUserHabits() async {
    final uri = Uri.parse('$apiUrl/users/${UserService.instance.id}/habits');
    final response = await http.get(uri, headers: _headers);

    return jsonDecode(response.body);
  }

  Future<Map> getHabitsList() async {
    final uri = Uri.parse('$apiUrl/habits');
    final response = await http.get(uri, headers: _headers);

    return jsonDecode(response.body);
  }

  Future<Map> uploadImage({required String id, required String image}) async {
    final uri = Uri.parse('$apiUrl/habits/$id/upload-image');
    final response = await http.post(
      uri,
      headers: _headers,
      body: jsonEncode({'base64_image': image}),
    );

    return jsonDecode(response.body);
  }
}
