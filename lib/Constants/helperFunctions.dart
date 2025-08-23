import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topline/Constants/colors.dart';

showTextSnackBar(context, content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
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
    {VoidCallback? onConfirm}
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: white,
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
                if (onConfirm != null) onConfirm();
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
