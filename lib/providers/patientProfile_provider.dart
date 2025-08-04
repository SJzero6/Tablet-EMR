import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/Models/patientProfileModel.dart';
import 'package:topline/Constants/apis.dart';

class ProfileService with ChangeNotifier {
  Future<ProfileData?> getPatientProfileData(String apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        print('Response body: $body');

        // Check if 'Result' exists
        if (body['Result'] != null) {
          var profileDataJson = body['Result'];

          try {
            var patientData = ProfileData.fromJson(profileDataJson);
            return patientData;
          } catch (e) {
            print(e.toString());
            return null;
          }
        } else {
          print(
              'Invalid response format. Expected a non-null object under "Result".');
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during HTTP request: $e');
    }

    return null;
  }
}
