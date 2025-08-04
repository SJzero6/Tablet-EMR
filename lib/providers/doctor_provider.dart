import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:topline/Constants/Models/doctorModel.dart';
import 'package:topline/Constants/Models/slotsModel.dart';
import 'package:topline/Constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:topline/providers/authentication_provider.dart';

class DoctorProvider with ChangeNotifier {
  Future<TimeslotResponse> fetchTimeslots(
      String fromDate, String toDate, int doctorId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl$slotsApi?from_date=$fromDate&to_date=$toDate&doctor_id=$doctorId'));

    if (response.statusCode == 200) {
      return TimeslotResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load timeslots');
    }
  }

  Future<List<DoctorData>> getDoctorData(
      AuthProvider authProvider, apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);

    List<DoctorData> doctorData = [];

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final result = body['Result'];
      for (var doctor in result) {
        DoctorData docData = DoctorData.fromJson(doctor);
        doctorData.add(docData);
        if (doctorData.isNotEmpty) {
          final docname = docData.doctorName;
          final docid = docData.id;
          authProvider.setDoctorInfo(docname.toString(), docid);
        }
      }
    } else {
      throw Exception('Failed to load doctor data');
    }
    print(doctorData);
    return doctorData;
  }
}
