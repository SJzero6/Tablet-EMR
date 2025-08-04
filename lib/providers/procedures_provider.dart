import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/Models/AccordianListModels/procdureModel.dart';
import 'package:topline/Constants/apis.dart';

class ProcedureListService with ChangeNotifier {
  Future<List<ProcedureData>> getProcedureTest(String apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);
    List<ProcedureData> procedureData = [];

    try {
      var response = await http.get(url);
      var body = jsonDecode(response.body);

      print(response.body); // Logging the response body
      // print('Debugging log');

      var tempRes = body['Result']["patientProcedues"];

      // Loop through tempRes and add parsed ProcedureData to the list
      tempRes.forEach((procedure) {
        try {
          procedureData.add(ProcedureData.fromJson(procedure));
        } catch (e) {
          print('Error parsing procedure: $e');
        }
      });

      procedureData.forEach((procedure) {
        print(procedure.procedureName);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }

    return procedureData;
  }
}
