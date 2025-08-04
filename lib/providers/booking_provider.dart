import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/Models/appoinmnetBookingModel.dart';
import 'dart:convert';

import 'package:topline/Constants/apis.dart';

class SlotBookingProvider extends ChangeNotifier {
  Appointment? _currentAppointment;

  Appointment? get currentAppointment => _currentAppointment;

  Future<http.Response> bookAppointment(
      String appointmentDate, String doctorId, String patientId) async {
    String apiUrl = baseUrl + bookingApi;

    Map<String, dynamic> requestData = {
      "appointment_date": appointmentDate,
      "doctor_id": doctorId,
      "patient_id": patientId,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(requestData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Handle successful booking
        _currentAppointment = Appointment(
          appointmentDate: appointmentDate,
          doctorId: doctorId,
          patientId: patientId,
        );
        notifyListeners();
        print('Appointment booked successfully! ${response.body}');
      } else {
        // Handle other status codes
        print('Failed to book appointment: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      // Handle network or other errors
      print('Error booking appointment: $e');
      rethrow;
    }
  }
}
