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
      String? token = await getToken();
      Map<String, String> headers = {};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        try {
          return jsonDecode(response.body);
        } catch (e) {
          return response.body; // Return plain text response
        }
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
      String? token = await getToken();
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        try {
          return jsonDecode(response.body);
        } catch (e) {
          return response.body; // Return plain text response
        }
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
      String? token = await getToken();
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      http.Response response = await http.put(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        try {
          return jsonDecode(response.body);
        } catch (e) {
          return response.body; // Return plain text response
        }
      } else {
        throw Exception(
            'There is a problem with the status code ${response.statusCode} with body ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to perform PUT request: $e');
    }
  }
}
