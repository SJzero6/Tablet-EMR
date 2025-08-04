import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:topline/Constants/apis.dart';

class ChiefComplaintsProvider with ChangeNotifier {
  String _chiefComplaints = '';

  String get chiefComplaints => _chiefComplaints;

  Future<void> fetchChiefComplaints(apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _chiefComplaints = data['Result']['ChiefComplaints'] ?? 'No complaints';
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Exception: $e');
    }
  }
}
