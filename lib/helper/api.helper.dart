import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  // Function to save the token
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Function to retrieve the token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<dynamic> get({required String url}) async {
    try {
      // Retrieve the token
      String? token = await getToken();

      // Set headers including Bearer token if available
      Map<String, String> headers = {};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      // Perform GET request
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            "There's a problem with status code ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Failed to perform GET request: $e');
    }
  }

  Future<dynamic> post({
    required String url,
    required dynamic body,
  }) async {
    try {
      // Retrieve the token
      String? token = await getToken();

      // Set headers including Bearer token if available
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      // Perform POST request
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'There is a problem with the status code ${response.statusCode} with body ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to perform POST request: $e');
    }
  }

  Future<dynamic> put({
    required String url,
    required dynamic body,
  }) async {
    try {
      // Retrieve the token
      String? token = await getToken();

      // Set headers including Bearer token if available
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      // Perform PUT request
      http.Response response = await http.put(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'There is a problem with the status code ${response.statusCode} with body ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to perform PUT request: $e');
    }
  }
}
