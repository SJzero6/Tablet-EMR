import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:topline/Constants/colors.dart';
import 'package:topline/Constants/helperFunctions.dart';

class PDFPreviewScreen extends StatelessWidget {
  final String pdfPath;
  final String orderName;

  PDFPreviewScreen(this.pdfPath, this.orderName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                secondaryPurple,
                primarylightPurple,
                secondarylightPurple,
                secondaryPurple,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(158, 158, 158, 1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: whitelightPurple,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 1),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                    child: Icon(
                  Icons.chevron_left_rounded,
                  color: white,
                  size: 0.06.sh,
                )),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              margin: const EdgeInsets.only(top: 1),
              child: Text(
                'Your Report',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 0.02.sh,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: PDFView(
          filePath: pdfPath,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _savePDFToDownloads(pdfPath, orderName, context);
        },
        backgroundColor: secondaryPurple,
        child: const Icon(Icons.download, color: Colors.white),
      ),
    );
  }

  Future<void> _savePDFToDownloads(
      String filePath, String fileName, BuildContext context) async {
    // Request storage permission
    bool hasPermission = await _requestPermission();
    if (!hasPermission) {
      return;
    }

    try {
      // Path to actual Downloads directory
      String downloadsPath = '/storage/emulated/0/Download';
      String newFilePath = path.join(downloadsPath, '$fileName.pdf');

      // Copy the file to Downloads
      File pdfFile = File(filePath);
      await pdfFile.copy(newFilePath);

      // Notify user of successful copy
      _showSplashDialog(context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('File saved to Downloads folder')),
      // );
    } catch (e) {
      print('Save failed: $e');

      DialogHelper.showCustomAlertDialog(
          context, 'Failed to save the file', 'assets/failed.gif');
    }
  }

  Future<bool> _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  void _showSplashDialog(
    context,
  ) {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/download.gif',
                          scale: 1.sp,
                        ),
                      ),
                      Text(
                        "Your PDF is Downloading...\nwait for while..",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(color: secondaryPurple)),
                      ),
                    ],
                  ),
                ),
              );
            });
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  content: SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.done,
                          color: secondarylightPurple,
                          size: 100,
                        ),
                        Text(
                          "Download success",
                          style: GoogleFonts.montserrat(
                              textStyle:
                                  const TextStyle(color: secondaryPurple)),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryPurple),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Done',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                );
              });
        });
      },
    );

    // Dismiss the dialog after 3 seconds
  }
}
