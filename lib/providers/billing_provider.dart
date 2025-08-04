import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topline/Constants/Models/billingModel.dart';
import 'package:topline/Constants/apis.dart';

class BillingDataService extends ChangeNotifier {
  Future<List<BillingData>> getBillingTest(apiurl) async {
    final url = Uri.parse(baseUrl + apiurl);
    List<BillingData> billingData = [];

    var response = await http.get(url);
    var body = jsonDecode(response.body);

    print(response.body);
    print('1232321131232341234231423423');

    for (var billing in body['Result']) {
      billingData.add(BillingData.fromJson(billing));
    }

    return billingData;
  }
}
