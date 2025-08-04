import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/Models/AccordianListModels/diagnosisModel.dart';
import 'package:topline/Constants/apis.dart';

class DiagonsisService with ChangeNotifier {
  Future<List<PatientDiagonosisData>> getDiagonosisData(apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);
    List<PatientDiagonosisData> diagonosisData = [];

    var response = await http.get(url);
    var body = jsonDecode(response.body);
    // print(response.body);
    // print(body['Result']["patientDiagonosis"][0]['name']);

    var tempRes = body["Result"]["patientDiagonosis"];

    // print("test +" + tempRes[0]['name'].runtimeType.toString());

    tempRes.forEach((obj) {
      try {
        diagonosisData.add(PatientDiagonosisData.fromJson(obj));
      } catch (e) {
        print(e.toString());
      }
    });
    // print(diagonosisData[0].name);

    return diagonosisData;
  }
}
