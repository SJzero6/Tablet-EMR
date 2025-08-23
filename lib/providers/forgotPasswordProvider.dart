import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/apis.dart';

class ForgotPasswordProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _password;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get password => _password;
  String? get errorMessage => _errorMessage;

  // Reset the state (clear password and error message)
  void resetState() {
    _password = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Function to make the API call and retrieve the password
  Future<void> sendPasswordReset(String email) async {
    final url = "$baseUrl$forgotpassword$email";

    _isLoading = true;
    _errorMessage = null;
    _password = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Success']) {
          // Ensure the state change happens after the build process
          Future.delayed(Duration.zero, () {
            _password = jsonResponse['Result'];
            _isLoading = false;
            notifyListeners();
          });
        } else {
          Future.delayed(Duration.zero, () {
            _errorMessage = "Email not found or error occurred!";
            _isLoading = false;
            notifyListeners();
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          _errorMessage = "Failed to send request. Please try again.";
          _isLoading = false;
          notifyListeners();
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        _errorMessage = "An error occurred. Please try again.";
        _isLoading = false;
        notifyListeners();
      });
    }
  }
 Future<bool> checkEmailExists(String email) async {
  try {
    _isLoading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse(baseUrl + forgotpassword),
      body: {'email': email},
    );

    _isLoading = false;
    notifyListeners();

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final result = data["Result"]?.toString().trim();

      print("API Response: $data"); // Debug

      if (result != null && result.toLowerCase() == "no user found") {
        return false; // Email not registered
      }
      return true; // Email exists
    }

    return false;
  } catch (e) {
    _isLoading = false;
    notifyListeners();
    print("Error checking email: $e");
    return false;
  }
}


  
}
