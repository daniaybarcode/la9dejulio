// api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.100.2:3000';

  static Future<http.Response> getRequest(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  static Future<http.Response> postRequest(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  static Future<http.Response> putRequest(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  static Future<http.Response> deleteRequest(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }


  static http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception('Failed to perform request: ${response.statusCode}');
    }
  }
}
