import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/Models/signupModels.dart';
import 'package:topline/Constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:topline/providers/authentication_provider.dart';

class CredentialProvider with ChangeNotifier {
  Future<Map<String, dynamic>> registerPatient(Registration student) async {
    const url = baseUrl + registrationAPI;
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(student.toJson()),
      );

      final data = jsonDecode(response.body);

      // Success case
      if (response.statusCode == 200 && data['Success'] == true) {
        return {'status': 'success', 'message': 'Registration successful'};
      }

      // Already exists or permission issue
      if (response.statusCode == 400 || response.statusCode == 404) {
        final message = (data['Message'] ?? '').toString().toLowerCase();
        final result = (data['Result'] ?? '').toString().toLowerCase();

        debugPrint("API Message: $message");
        debugPrint("API Result: $result");

        if (result.contains('emirates id') &&
            result.contains('not correspond')) {
          return {
            'status': 'emirates_id_error',
            'message':
                'Your Emirates ID is not registered with Tablet 10 EMR. Contact Your Clinic'
          };
        } else if (message.contains('already exists')) {
          return {
            'status': 'already_exists',
            'message': 'Patient is already registered'
          };
        } else if (message.contains('permission')) {
          return {
            'status': 'permission_error',
            'message': 'You don’t have permission to perform this action'
          };
        } else {
          return {
            'status': 'error',
            'message': message.isNotEmpty
                ? message
                : result.isNotEmpty
                    ? result
                    : 'Unknown error'
          };
        }
      }

      // Any other HTTP error
      else {
        return {
          'status': 'error',
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (error) {
      return {'status': 'error', 'message': error.toString()};
    }
  }

  Future<void> loginUser(
      BuildContext context, String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + loginAPI),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Username': username,
          'Password': password,
        }),
      );

      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['Success'] == true) {
          //print('Login successful');

          var result = responseData['Result'][0];
          // print('UserId: ${result['UserId']}, Username: ${result['Username']}');

          final username = result['Username'];
          final userId = result["UserId"];

          // Get the existing instance of AuthProvider
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);

          // Set user info
          authProvider.setUserInfo(username, userId);
          //  print('UserId: $userId, Username: $username');
        } else {
          // Handle unsuccessful login, display message
          String errorMessage;

          if (responseData['Result'] != null &&
              responseData['Result'].isEmpty) {
            errorMessage = 'Invalid username or password';
          } else {
            errorMessage = 'Unknown error occurred';
          }

          throw Exception(errorMessage);
        }
      } else {
        throw Exception(
            'Failed to login with status code ${response.statusCode}');
      }
    } catch (e) {
      //print('Error: $e');
      throw Exception('$e');
    }
  }
}
