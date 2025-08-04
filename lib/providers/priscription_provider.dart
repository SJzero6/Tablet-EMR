import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/Models/AccordianListModels/priscriptionModel.dart';
import 'package:topline/Constants/apis.dart';

class PrescriptionListService with ChangeNotifier {
  Future<List<PatientPrescriptionData>> getPriscriptionTest(apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);
    List<PatientPrescriptionData> priscriptionData = [];

    var response = await http.get(url);
    print(response.body);
    var body = jsonDecode(response.body);
    // print("Aman");
    // print(body);

    // print('1232321131232341234231423423');
    // print(body['Result']["patientPrescriptions"]);
    // print("ok");
    // print(body['Result']["patientPrescriptions"]["medicine"]);

    var tempRes = body['Result']["patientPrescriptions"];

    //     ["medicineFrequency"]["route"];
    // print("tempres +" + tempRes[0]['PrescriptionName'].runtimeType.toString());
    // print("testing");
    // print(tempRes.length);

    tempRes.forEach((obj) {
      //   print("foreach+");
      // print(obj['PrescriptionName']);
      try {
        priscriptionData.add(PatientPrescriptionData.fromJson(obj));
      } catch (e) {
        print(e.toString());
      }
    });

    // for (var procedure in tempRes) {
    //   print(procedure);
    //   procedureData.add(ProcedureData.fromJson(procedure));
    // }
    // print("resutl procr+");

    // print(priscriptionData[0].route);
    return priscriptionData;
  }
}
