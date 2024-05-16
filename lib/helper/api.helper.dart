import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String? authToken;

  Api({this.authToken});

  // Function to save the token
  void saveToken(String token) {
    // If needed, you can add additional logic here, like storing the token securely
    // For now, it's just stored as a class member
  }

  // Function to retrieve the token
  String? getToken() {
    return authToken;
  }

  Future<dynamic> get({required String url, String? token}) async {
    try {
      Map<String, String> headers = {};
      if (token != null) {
        headers.addAll({
          'Authorization': 'Bearer $token',
        });
      }
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
    String? token,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

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
    String? token,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

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
