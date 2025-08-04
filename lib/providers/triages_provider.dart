import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/Models/AccordianListModels/triagesModel.dart';
import 'package:topline/Constants/apis.dart';

class TriagesListService with ChangeNotifier {
  Future<List<AppointmentTriagesData>> getTriagesData(apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);
    List<AppointmentTriagesData> triagesData = [];

    var response = await http.get(url);
    var body = jsonDecode(response.body);
    print(response.body);

    print("topline234");
    print(body['Result']["patientAppoinmnetTriages"][0]['BP']);
    print("Dubai");
    var tempRes = body["Result"]["patientAppoinmnetTriages"];

    print("tempres +" + tempRes[0]['BP'].runtimeType.toString());

    tempRes.forEach((triages) {
      try {
        triagesData.add(AppointmentTriagesData.fromJson(triages));
      } catch (e) {
        print(e.toString());
      }
    });
    print(triagesData[0].bmi);

    return triagesData;
  }
}
