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

        // Retrieve user data and firstLoginToday flag
        Map<String, dynamic> user = data['user'];
        bool firstLoginToday = data['firstLoginToday'];

        print('Login successful.');
        return {
          'success': true,
          'message': data['message'],
          'user': user,
          'firstLoginToday': firstLoginToday,
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

Future<Map<String, dynamic>> getUserDetails() async {
  try {
    final token = await _getToken();
    if (token == null) {
      print('No token found. Please log in.');
      return {
        'success': false,
        'message': 'User not authenticated.',
      };
    }

      print('Token: $token');
      print('Requesting user details...');
      final response = await http.get(
        Uri.parse('$baseUrl/api/users/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'user': data['user'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Error fetching user data.',
        };
      }
    } catch (e) {
      print('Error: $e');
      return {
        'success': false,
        'message': 'An error occurred while retrieving user data.',
      };
    }
  }

 Future<Map<String, dynamic>> createSchedule() async {
  try {
    final token = await _getToken();

    if (token == null) {
      return {
        'success': false,
        'message': 'User not authenticated.',
      };
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/predict'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data['success'] == true) {
        // Schedule created successfully
        return {
          'success': true,
          'message': data['message'],
          'predicted_tasks_finished': data['predicted_tasks_finished'],
          'predicted_study_hours': data['predicted_study_hours'],
          'schedule': data['schedule'], // Contains schedule details
          'tasks_scheduled': data['tasks_scheduled'], // List of task details
        };
      } else {
        // Handle cases where action is required or when no tasks are available
        String actionRequired = data['action_required'] ?? '';

        return {
          'success': false,
          'message': data['message'],
          'predicted_tasks_finished': data['predicted_tasks_finished'],
          'predicted_study_hours': data['predicted_study_hours'],
          'action_required': actionRequired,
        };
      }
    } else {
      // Handle other status codes
      return {
        'success': false,
        'message': 'Server error: ${response.statusCode}',
        'predicted_tasks_finished': null,
      };
    }
  } catch (e) {
    print('Error in createSchedule: $e');
    return {
      'success': false,
      'message': 'An error occurred while creating the schedule.',
      'predicted_tasks_finished': null,
    };
  }
}
 // Method to call the /api/get_schedule endpoint
  Future<Map<String, dynamic>> getSchedule() async {
    try {
      final token = await _getToken();

      if (token == null) {
        return {
          'success': false,
          'message': 'User not authenticated.',
        };
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/get_schedule'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success']) {
          // Schedule retrieved successfully
          return {
            'success': true,
            'message': data['message'],
            'schedule': data['schedule'], // Contains schedule details
            'tasks_scheduled': data['tasks_scheduled'], // List of task details
          };
        } else {
          // Handle cases where schedule is not found
          return {
            'success': false,
            'message': data['message'],
          };
        }
      } else if (response.statusCode == 404) {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message': data['message'],
        };
      } else {
        // Handle other status codes
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('Error in getSchedule: $e');
      return {
        'success': false,
        'message': 'An error occurred while retrieving the schedule.',
      };
    }
  } // Method to add a PomoActivity
  Future<Map<String, dynamic>> addPomoActivity(
      String activityType, String activityDuration) async {
    try {
      final token = await _getToken();
      if (token == null) {
        print('No token found. Please log in.');
        return {
          'success': false,
          'message': 'User not authenticated.',
        };
      }

      // Validate activity duration
      double? duration = double.tryParse(activityDuration);
      if (duration == null || duration <= 0 || duration > 24) {
        return {
          'success': false,
          'message': 'Activity duration must be a number between 0 and 24.',
        };
      }

      // Prepare the request
      final response = await http.post(
        Uri.parse('$baseUrl/api/pomo_activities/add'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'activityType': activityType,
          'activityDuration': activityDuration,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Activity added successfully
        print('PomoActivity added successfully.');
        return {
          'success': true,
          'message': data['message'],
        };
      } else {
        // Failed to add activity
        print('Failed to add PomoActivity: ${data['message']}');
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to add PomoActivity.',
        };
      }
    } catch (e) {
      print('Error while adding PomoActivity: $e');
      return {
        'success': false,
        'message': 'An error occurred while adding the PomoActivity.',
      };
    }
  }
  Future<Map<String, dynamic>> getPomoActivities() async {
  try {
    final token = await _getToken();
    if (token == null) {
      print('No token found. Please log in.');
      return {
        'success': false,
        'message': 'User not authenticated.',
      };
    }

    // Prepare the request
    final response = await http.get(
      Uri.parse('$baseUrl/api/pomo_activities'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Data retrieved successfully
      print('PomoActivities retrieved successfully.');
      return {
        'success': true,
        'activities': data['activities'],
      };
    } else {
      // Failed to retrieve data
      print('Failed to retrieve PomoActivities: ${data['message']}');
      return {
        'success': false,
        'message': data['message'] ?? 'Failed to retrieve PomoActivities.',
      };
    }
  } catch (e) {
    print('Error while retrieving PomoActivities: $e');
    return {
      'success': false,
      'message': 'An error occurred while retrieving PomoActivities.',
    };
  }
}
Future<Map<String, dynamic>> getActivitySummaries() async {
  try {
    final token = await _getToken();
    if (token == null) {
      print('No token found. Please log in.');
      return {
        'success': false,
        'message': 'User not authenticated.',
      };
    }

    // Prepare the request
    final response = await http.get(
      Uri.parse('$baseUrl/api/activities/summary'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Summaries retrieved successfully
      print('Activity summaries retrieved successfully.');
      return {
        'success': true,
        'summaries': data['summaries'],
      };
    } else {
      // Failed to retrieve summaries
      print('Failed to retrieve activity summaries: ${data['message']}');
      return {
        'success': false,
        'message': data['message'] ?? 'Failed to retrieve activity summaries.',
      };
    }
  } catch (e) {
    print('Error while retrieving activity summaries: $e');
    return {
      'success': false,
      'message': 'An error occurred while retrieving activity summaries.',
    };
  }
}
Future<Map<String, dynamic>> closeTask(int taskId) async {
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
        Uri.parse('$baseUrl/api/tasks/close/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Task closed successfully
        print('Task closed successfully.');
        return {
          'success': true,
          'message': data['message'],
        };
      } else {
      // Failed to close task
      print('Failed to close task: ${data['message']}');
      print('Status code: ${response.statusCode}');
      return {
        'success': false,
        'message': data['message'] ?? 'Failed to close task with status code ${response.statusCode}.',
      };
    }
    } catch (e,stackTrace) {
      print('Error while closing task: $e');
      print('Stack trace: $stackTrace');
      return {
        'success': false,
        'message': 'An error occurred while closing the task.',
      };
    }
  }


}
