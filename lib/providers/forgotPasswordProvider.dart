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
    final url = "$baseUrl$forgotpassword$email";

    // Set loading state at the beginning
    _isLoading = true;
    _errorMessage = null; // Clear previous errors
    _password = null; // Clear previous password
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));

      final jsonResponse = json.decode(response.body);
        
      // Check for success from the API's response body
      if (jsonResponse['Success']) {
        // Now, check the 'Result' field to see if a user was actually found.
        if (jsonResponse['Result'] != "No User Found") {
          _password = jsonResponse['Result']; // Set the password
          _isLoading = false;
          notifyListeners();
          return true; // Return true on success
        } else {
          _errorMessage = "Email not found or error occurred!"; // Set the error message
          _isLoading = false;
          notifyListeners();
          return false; // Return false because no user was found
        }
      } else {
        _errorMessage = "An API error occurred. Please check the API response.";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      // Handle network exceptions and JSON decoding errors
      _errorMessage = "An error occurred. Please try again.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
}
