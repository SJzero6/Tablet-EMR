import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/Models/appoinmnetModel.dart';
import 'package:topline/Constants/Models/updateAppoinmnetModel.dart';
import 'package:topline/Constants/apis.dart';
import 'package:topline/providers/authentication_provider.dart';

class AppointmentProvider extends ChangeNotifier {
  Future<List<AppoinmentData>> getAppoinmentTest(
      AuthProvider authprovider, apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);
    List<AppoinmentData> appointData = [];

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final result = body['Result'];
      for (var appoinment in result) {
        AppoinmentData appoinmentData = AppoinmentData.fromJson(appoinment);

        appointData.add(appoinmentData);
        if (appointData.isNotEmpty) {
          final appoinmentdate = appoinmentData.appoinmentDate;
          final appoinmenttime = appoinmentData.appointmentTime;
          final appoinmentId = appoinmentData.appointmentId;
          authprovider.setAppointInfo(appoinmentdate.toString(),
              appoinmenttime.toString(), appoinmentId.toString());
        }
      }
    } else {
      throw Exception('Failed to load Appoinment Data data');
    }
    print(appointData);
    return appointData;
  }

  List<AppoinmentData> _appointments = [];

  List<AppoinmentData> get appointments => _appointments;

  Future<void> cancelAppointment(String appointId, String cancelReason) async {
    final url = Uri.parse(baseUrl + cancelAppoinment);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'appointment_id': appointId,
      'cancel_reason': cancelReason,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Successful cancellation
        _appointments.removeWhere(
            (appointment) => appointment.appointmentId == appointId);

        notifyListeners();
      } else {
        // Handle error
        throw Exception(
            'Failed to cancel appointment: ${response.statusCode}\t\t\t${appointId}');
      }
    } catch (e) {
      throw Exception('Error canceling appointment: $e');
    }
  }

  List<UpdateAppoinmentData> _updateAppointments = [];

  List<UpdateAppoinmentData> get updateAppointments => _updateAppointments;

  Future<void> updateAppointmentSlot(String appointmentId,
      String appointmentDate, String doctorId, String patientId) async {
    final url = Uri.parse(baseUrl + updateAppoinment);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'appointment_id': appointmentId,
      'appointment_date': appointmentDate,
      'doctor_id': doctorId,
      'patient_id': patientId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Successful update from the API
        print('Appointment updated successfully');

        // Update the local state
        final index = _updateAppointments.indexWhere((updateAppointment) =>
            updateAppointment.appointmentId == appointmentId);
        if (index != -1) {
          _updateAppointments[index] = _updateAppointments[index]
              .copyWith(appoinmentDate: appointmentDate);
          notifyListeners();
        }
      } else {
        // Handle API error
        print('Failed to update appointment: ${response.statusCode}');
        throw Exception('Failed to update appointment');
      }
    } catch (e) {
      print('Error updating appointment: $e');
      throw Exception('Error updating appointment: $e');
    }
  }
}
