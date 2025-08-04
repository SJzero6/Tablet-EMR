import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topline/Constants/colors.dart';

showTextSnackBar(context, content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      content: Text(
        '$content',
        style: GoogleFonts.montserrat(),
      )));
}

class DialogHelper {
  static void showCustomAlertDialog(
    BuildContext context,
    String content,
    String image,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Alert",
            style: GoogleFonts.montserrat(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image,
                scale: 5,
              ),
              const SizedBox(height: 10),
              Text(
                content,
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(color: secondaryPurple)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(color: secondaryPurple)),
              ),
            ),
          ],
        );
      },
    );
  }
}
