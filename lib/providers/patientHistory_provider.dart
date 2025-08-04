import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/Models/patientHistoryModel.dart';
import 'package:topline/Constants/apis.dart';
import 'package:topline/providers/authentication_provider.dart';

class PatientHistoryService with ChangeNotifier {
  Future<List<RecentTreatmentData>> getTreatmentList(context, apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);
    List<RecentTreatmentData> treatmentData = [];

    var response = await http.get(url);
    var body = jsonDecode(response.body);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    for (var treatment in body['Result']) {
      RecentTreatmentData treatData = RecentTreatmentData.fromJson(treatment);
      treatmentData.add(treatData);
      if (treatmentData.isNotEmpty) {
        final treatId = treatData.id;
        authProvider.setTreatmentInfo(treatId);
        // print("defededededededed$treatId");
      }
    }
    return treatmentData;
  }
}
