import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/Models/signupModels.dart';
import 'package:topline/Constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:topline/providers/authentication_provider.dart';

class CredentialProvider with ChangeNotifier {
  Future<void> registerPatient(Registration student) async {
    const url = baseUrl + registrationAPI;
    var headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(student.toJson()),
      );

      if (response.statusCode == 200) {
        print('Registration successful');
      } else {
        print(student);

        print('Failed to register: ${response.body}');
        throw Exception('Failed to register');
      }
    } catch (error) {
      print('Exception: $error');
      throw error;
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

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['Success'] == true) {
          print('Login successful');

          var result = responseData['Result'][0];
          print('UserId: ${result['UserId']}, Username: ${result['Username']}');

          final username = result['Username'];
          final userId = result["UserId"];

          // Get the existing instance of AuthProvider
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);

          // Set user info
          authProvider.setUserInfo(username, userId);
          print('UserId: $userId, Username: $username');
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
      print('Error: $e');
      throw Exception('$e');
    }
  }
}
