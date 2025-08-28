import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:topline/Constants/Models/updateSlotsModel.dart';
import 'package:topline/Constants/apis.dart';
// import 'package:topline/providers/authentication_provider.dart';

class TimeslotProvider with ChangeNotifier {
  bool loading = true;
  List<String> morningSlots = [];
  List<String> afternoonSlots = [];
  List<String> eveningSlots = [];

  Future<void> fetchTimeslots(
      String fromDate, String toDate, String doctorId) async {
    loading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          '$baseUrl$slotsApi?from_date=$fromDate&to_date=$toDate&doctor_id=$doctorId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['has_timeslots']) {
          List<String> timeslots =
              List<String>.from(data['timeslots'][0]['time']);
          _categorizeTimeslots(timeslots);
        }
      } else {
        throw Exception('Failed to load timeslots');
      }
    } catch (e) {
      // Handle error
      print('Error fetching timeslots: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void _categorizeTimeslots(List<String> timeslots) {
    morningSlots.clear();
    afternoonSlots.clear();
    eveningSlots.clear();

    final timePattern =
        RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)', caseSensitive: false);

    for (var time in timeslots) {
      try {
        final match = timePattern.firstMatch(time);
        if (match != null) {
          int hour = int.parse(match.group(1)!);
          final minute = int.parse(match.group(2)!);
          final period = match.group(3)!.toUpperCase();

          if (period == 'PM' && hour != 12) {
            hour += 12;
          } else if (period == 'AM' && hour == 12) {
            hour = 0;
          }

          final parsedTime = DateTime(2024, 1, 1, hour, minute);

          if (parsedTime.isBefore(DateTime(2024, 1, 1, 12, 00))) {
            morningSlots.add(time);
          } else if (parsedTime.isBefore(DateTime(2024, 1, 1, 18, 0))) {
            afternoonSlots.add(time);
          } else {
            eveningSlots.add(time);
          }
        } else {
          print('Invalid time format: $time');
        }
      } catch (e) {
        print('Error parsing time $time: $e');
      }
    }
  }

  Future<UpdateTimeSlot> updateFetchTimeSlots(
      String fromDate, String toDate, int doctorId) async {
        
    final url =
        '$baseUrl$slotsApi?from_date=$fromDate&to_date=$toDate&doctor_id=$doctorId';
    print('Fetching from URL: $url');

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      final jsonData = json.decode(response.body);
      print('Parsed JSON: $jsonData');
      return UpdateTimeSlot.fromJson(jsonData);
    } else {
      print(
          'Failed to load time slots: ${response.statusCode} ${response.reasonPhrase}');
      throw Exception('Failed to load time slots');
    }
  }
}
