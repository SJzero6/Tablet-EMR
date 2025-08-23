import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/apis.dart';

class ResetPasswordProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Resets the password for the given email
  /// Returns a map with keys: 'success' (bool) and 'message' (String)
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    _setLoading(true);

    try {
      final url = Uri.parse('$baseUrl$resetPass');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "newPassword": newPassword,
        }),
      );

      _setLoading(false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': data["Success"] ?? false,
          'message': data["Result"] ?? "Something went wrong",
        };
      } else {
        return {
          'success': false,
          'message': 'Failed with status code: ${response.statusCode}',
        };
      }
    } catch (e) {
      _setLoading(false);
      debugPrint('Reset password error: $e');
      return {
        'success': false,
        'message': 'An error occurred. Please try again.',
      };
    }
  }
}
