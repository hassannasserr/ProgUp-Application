import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:io';
class ApiService {
  final String baseUrl = 'https://s7s1.pythonanywhere.com';
 HttpClient createHttpClient() {
    final client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }
  // Secure storage for JWT token
  final storage = const FlutterSecureStorage();

  // Method to store token securely
  Future<void> _storeToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  // Method to read token
  Future<String?> _getToken() async {
    return await storage.read(key: 'jwt_token');
  }

  // Method to delete token (on logout)
  Future<void> _deleteToken() async {
    await storage.delete(key: 'jwt_token');
  }

  // Updated registerUser method
  Future<Map<String, dynamic>> registerUser(String fname, String lname, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fname': fname,
          'lname': lname,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        print('User registered successfully.');
        return {
          'success': true,
          'message': data['message'],
        };
      } else {
        // Registration failed
        print('Failed to register user: ${data['message']}');
        return {
          'success': false,
          'message': data['message'],
        };
      }
    } catch (e) {
      print('Error during registration: $e');
      return {
        'success': false,
        'message': 'An error occurred during registration.',
      };
    }
  }

  // Updated login method
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

      if (response.statusCode == 200) {
        // Store JWT token securely
        String token = data['token'];
        await _storeToken(token);

        // Optionally, store user data if needed
        Map<String, dynamic> user = data['user'];

        print('Login successful.');
        return {
          'success': true,
          'message': data['message'],
          'user': user,
        };
      } else {
        // Login failed
        print('Login failed: ${data['message']}');
        return {
          'success': false,
          'message': data['message'],
        };
      }
    } catch (e) {
      print('Error during login: $e');
      return {
        'success': false,
        'message': 'An error occurred during login.',
      };
    }
  }

  // Method to logout (delete token)
  Future<void> logout() async {
    await _deleteToken();
    print('Logged out successfully.');
  }

  // Method to add a task (protected route)
Future<Map<String, dynamic>> addTask(
    String taskName,
    String taskDetails,
    String deadline,
    String type,
    int taskPriority) async {  // Added 'taskPriority' parameter
  try {
    final token = await _getToken();
    if (token == null) {
      print('No token found. Please log in.');
      return {
        'success': false,
        'message': 'User not authenticated.',
      };
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/tasks/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'taskName': taskName,
        'taskDetails': taskDetails,
        'deadline': deadline,
        'type': type,
        'taskPriority': taskPriority,  // Added 'taskPriority' to the body
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Task added successfully
      print('Task added successfully.');
      return {
        'success': true,
        'message': data['message'],
      };
    } else {
      // Failed to add task
      print('Failed to add task: ${data['message']}');
      return {
        'success': false,
        'message': data['message'],
      };
    }
  } catch (e) {
    print('Error while adding task: $e');
    return {
      'success': false,
      'message': 'An error occurred while adding the task.',
    };
  }
}
  // Method to update a task (protected route)
  Future<Map<String, dynamic>> updateTask(int taskId, String taskName, String taskDetails, String deadline, String status, String type) async {
    try {
      final token = await _getToken();
      if (token == null) {
        print('No token found. Please log in.');
        return {
          'success': false,
          'message': 'User not authenticated.',
        };
      }

      final response = await http.put(
        Uri.parse('$baseUrl/api/tasks/update/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'taskName': taskName,
          'taskDetails': taskDetails,
          'deadline': deadline,
          'status': status,
          'type': type,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Task updated successfully
        print('Task updated successfully.');
        return {
          'success': true,
          'message': data['message'],
        };
      } else {
        // Failed to update task
        print('Failed to update task: ${data['message']}');
        return {
          'success': false,
          'message': data['message'],
        };
      }
    } catch (e) {
      print('Error while updating task: $e');
      return {
        'success': false,
        'message': 'An error occurred while updating the task.',
      };
    }
  }

  // Method to delete a task (protected route)
  Future<Map<String, dynamic>> deleteTask(int taskId) async {
    try {
      final token = await _getToken();
      if (token == null) {
        print('No token found. Please log in.');
        return {
          'success': false,
          'message': 'User not authenticated.',
        };
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/api/tasks/delete/$taskId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Task deleted successfully
        print('Task deleted successfully.');
        return {
          'success': true,
          'message': data['message'],
        };
      } else {
        // Failed to delete task
        print('Failed to delete task: ${data['message']}');
        return {
          'success': false,
          'message': data['message'],
        };
      }
    } catch (e) {
      print('Error while deleting task: $e');
      return {
        'success': false,
        'message': 'An error occurred while deleting the task.',
      };
    }
  }

  // Method to get tasks (protected route)
  Future<Map<String, dynamic>> getTasks() async {
    try {
      final token = await _getToken();
      if (token == null) {
        print('No token found. Please log in.');
        return {
          'success': false,
          'message': 'User not authenticated.',
        };
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/tasks'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Tasks retrieved successfully
        print('Tasks retrieved successfully.');
        return {
          'success': true,
          'tasks': data['tasks'],  // Assuming the tasks are returned in a 'tasks' field
        };
      } else {
        // Failed to get tasks
        print('Failed to get tasks: ${data['message']}');
        return {
          'success': false,
          'message': data['message'],
        };
      }
    } catch (e) {
      print('Error while retrieving tasks: $e');
      return {
        'success': false,
        'message': 'An error occurred while retrieving tasks.',
      };
    }
  }
  // New method to add an activity
  // Method to add an activity (modified to include socialHours)
Future<Map<String, dynamic>> addActivity(
    String asleepTime, String awakeTime, String stressLevel, String socialHours) async {
  try {
    final token = await _getToken();
    if (token == null) {
      print('No token found. Please log in.');
      return {
        'success': false,
        'message': 'User not authenticated.',
      };
    }

    // Validate stress level
    if (!['low', 'moderate', 'high'].contains(stressLevel.toLowerCase())) {
      return {
        'success': false,
        'message': 'Invalid stress level. Must be one of: low, moderate, high.',
      };
    }

    // Validate social hours
    double? socialHoursValue = double.tryParse(socialHours);
    if (socialHoursValue == null || socialHoursValue < 0 || socialHoursValue > 24) {
      return {
        'success': false,
        'message': 'Social hours must be a number between 0 and 24.',
      };
    }

    // Prepare the request
    final response = await http.post(
      Uri.parse('$baseUrl/api/activities/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'asleepTime': asleepTime,    // Expected format: 'HH:MM AM/PM'
        'awakeTime': awakeTime,      // Expected format: 'HH:MM AM/PM'
        'stressLevel': stressLevel.toLowerCase(),
        'socialHours': socialHours,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      // Activity added successfully
      print('Activity added successfully.');
      return {
        'success': true,
        'message': data['message'],
      };
    } else {
      // Failed to add activity
      print('Failed to add activity: ${data['message']}');
      return {
        'success': false,
        'message': data['message'],
      };
    }
  } catch (e) {
    print('Error while adding activity: $e');
    return {
      'success': false,
      'message': 'An error occurred while adding the activity.',
    };
  }
}
  // New method to change password
  Future<Map<String, dynamic>> changePassword(
      String currentPassword, String newPassword, String confirmNewPassword) async {
    try {
      final token = await _getToken();
      if (token == null) {
        print('No token found. Please log in.');
        return {
          'success': false,
          'message': 'User not authenticated.',
        };
      }

      // Validate new passwords match
      if (newPassword != confirmNewPassword) {
        return {
          'success': false,
          'message': 'New passwords do not match.',
        };
      }

      // Prepare the request
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/change_password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'confirmNewPassword': confirmNewPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Password changed successfully
        print('Password updated successfully.');
        return {
          'success': true,
          'message': data['message'],
        };
      } else {
        // Failed to change password
        print('Failed to update password: ${data['message']}');
        return {
          'success': false,
          'message': data['message'],
        };
      }
    } catch (e) {
      print('Error while changing password: $e');
      return {
        'success': false,
        'message': 'An error occurred while updating the password.',
      };
    }
  }
}