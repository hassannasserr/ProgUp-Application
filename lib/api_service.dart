import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ApiService {
  final String baseUrl = 'https://s7s1.pythonanywhere.com';
  HttpClient createHttpClient() {
    final client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }
  // Existing register method
Future<bool> registerUser(String fname, String lname, String email, String password) async {
    try {
      final client = createHttpClient();
      final request = await client.postUrl(Uri.parse('$baseUrl/api/users/register'));
      request.headers.set('Content-Type', 'application/json');
      request.headers.set('Accept', 'application/json');
      request.add(utf8.encode(jsonEncode({
        'fname': fname,
        'lname': lname,
        'email': email,
        'password': password,
      })));

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to register user: ${responseBody}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // New login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = jsonDecode(response.body);
      return {
        'success': response.statusCode == 200,
        'message': data['message'],
        'user': data['user'],  // Will contain user data if login successful
      };
    } catch (e) {
      print('Error: $e');
      return {
        'success': false,
        'message': 'Connection error',
        'user': null
      };
    }
  }
}