import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/Models/AccordianListModels/problemModel.dart';
import 'package:topline/Constants/apis.dart';

class ProblemListService with ChangeNotifier {
  Future<List<PatientProblemData>> getProblemData(apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);
    List<PatientProblemData> problemData = [];

    var response = await http.get(url);
    var body = jsonDecode(response.body);
    // print(response.body);
    // print(body['Result']["patientDiagonosis"][0]['name']);

    var tempRes = body["Result"]["patientProblems"];

    // print("test +" + tempRes[0]['name'].runtimeType.toString());

    tempRes.forEach((obj) {
      try {
        problemData.add(PatientProblemData.fromJson(obj));
      } catch (e) {
        print(e.toString());
      }
    });
    // print(problemData[0].name);

    return problemData;
  }
}
