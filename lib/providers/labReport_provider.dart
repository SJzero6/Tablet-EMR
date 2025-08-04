import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:topline/Constants/apis.dart';

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:topline/Screens/reportPdfViewScreen.dart';

class LabReportService extends ChangeNotifier {
  Future<List<Map<String, String>>> fetchBase64StringsAndOrderNames(
      String apiurl) async {
    final response = await http.get(Uri.parse(baseUrl + apiurl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final results = jsonResponse['Result'];
      print('Hello sooraj$results');
      if (results is List) {
        return results.map<Map<String, String>>((result) {
          String base64Content = result['Content'];

          base64Content = base64Content.replaceAll('^^PDF^Base64^', '');
          print('sooraj6666666666666666$base64Content');
          print('sooraj6666666666666666${result['OrderName']}');
          return {
            'FileType': result['FileType'].toString(),
            'base64String': base64Content,
            'orderName': result['OrderName'].toString(),
            'createDate': result['createDate'].toString()
          };
        }).toList();
      } else {
        throw Exception('Invalid response format: Result is not a List');
      }
    } else {
      throw Exception('Failed to load Base64 strings and order names');
    }
  }

  Future<String> _getPdfFileFromBase64(String base64String) async {
    try {
      final List<int> bytes = base64Decode(base64String);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/document.pdf');
      await file.writeAsBytes(bytes);
      print("sooraj646464646464646464646${file.path}");
      print('PDF file saved to: ${file.path}');
      return file.path;
    } catch (e) {
      print('Error saving PDF file: $e');
      throw Exception('Failed to save PDF file');
    }
  }

  Future<void> previewPDF(BuildContext context, String base64String,
      String orderName, String orderdate) async {
    String formatedName = orderName.replaceAll('\\n', "\n");
    try {
      final pdfPath = await _getPdfFileFromBase64(base64String);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PDFPreviewScreen(
            pdfPath,
            formatedName,
          ),
        ),
      );
    } catch (e) {
      print('Error previewing PDF: $e');
    }
  }
}
