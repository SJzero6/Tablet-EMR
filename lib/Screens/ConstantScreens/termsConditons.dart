import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:topline/Constants/colors.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String currentdate = DateFormat('yyyy-MM-dd').format(date);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        toolbarHeight: 80.h,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 1),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Center(
                    child: Icon(
                  Icons.chevron_left_rounded,
                  color: white,
                  size: 0.06.sh,
                )),
              ),
            ),
            SizedBox(
              width: 0.05.w,
            ),
            Text(
              'Terms & Consitions',
              style: GoogleFonts.afacad(
                color: white,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            // GestureDetector(
            //   onTap: _pickImage,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(width: 3, color: Colors.white),
            //     ),
            //     child: CircleAvatar(
            //       radius: 25,
            //       backgroundColor: Colors.white,
            //       backgroundImage: _profileImage != null
            //           ? FileImage(_profileImage!)
            //           : const AssetImage('assets/user-circle-regular-240.png')
            //               as ImageProvider,
            //       child: _profileImage == null
            //           ? const Icon(Icons.person, size: 0)
            //           : null,
            //     ),
            //   ),
            // ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Center(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/logo.png',
                    opacity: const AlwaysStoppedAnimation(0.2),
                  ))),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Updated: $currentdate',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: secondaryPurple),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Welcome to Tablet Doctor Appoinment Booking Application. By using the App, you agree to comply with and be bound by the following terms and conditions ("Terms"). Please review these Terms carefully. If you do not agree to these Terms, you should not use the App.',
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '1. Acceptance of Terms\n\n'
                    'By using the App, you agree to these Terms and acknowledge that you have read and understood them. If you do not agree, you may not use the App.',
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '2. Changes to Terms\n\n'
                    'We reserve the right to modify these Terms at any time. Changes will be effective upon posting on the App. Your continued use of the App after changes are posted constitutes your acceptance of the amended Terms.',
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '3. User Accounts\n\n'
                    "To book appointments, you may need to create an account. You agree to provide accurate and complete information and to update your information as necessary. You are responsible for maintaining the confidentiality of your account credentials.",
                  ),
                  const SizedBox(height: 16.0),
                  const Text("4. Booking Appointments\n\n"
                      "Appointment Availability: Appointment slots are subject to availability. We do not guarantee the availability of any specific slot or doctor.\n"
                      "Booking Confirmation: A booking is confirmed when you receive a confirmation message via the App.\n"
                      "Cancellation and Rescheduling: Users may cancel or reschedule appointments according to the cancellation policy outlined in the App."),
                  // Add more sections similarly
                  const SizedBox(height: 16.0),
                  const Text("5. User Responsibilities\n\n"
                      "Accurate Information: You agree to provide accurate information for booking and communicating with doctors.\n"
                      "Compliance: You agree to comply with all applicable laws and regulations when using the App."),
                  const SizedBox(height: 16.0),
                  const Text("7. Privacy Policy\n\n"
                      "Our Privacy Policy explains how we collect, use, and protect your personal information. By using the App, you agree to the terms of our Privacy Policy."),
                  // Add more sections similarly
                  const SizedBox(height: 16.0),

                  const Text("8. Disclaimers\n\n"
                      "Medical Advice: The App is a platform for booking appointments and does not provide medical advice. All medical consultations are provided by licensed doctors."
                      "No Warranty: We do not warrant that the App will be error-free or uninterrupted."),
                  const SizedBox(height: 16.0),

                  const Text("9. Limitation of Liability\n\n"
                      "We are not liable for any indirect, incidental, or consequential damages arising from your use of the App, including but not limited to the accuracy of information provided by doctors or any medical advice received."),
                  // Add more sections similarly
                  const SizedBox(height: 16.0),
                  const Text(
                    '10. Governing Law\n\n'
                    'These Terms are governed by the laws of [Jurisdiction]. Any disputes arising from these Terms or the use of the App will be subject to the exclusive jurisdiction of the courts of [Jurisdiction].',
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '11. Contact Us\n\n'
                    'If you have any questions about these Terms, please contact us at info@toplineuae.com.',
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Tablet EMR\n'
                    'Topline Computer Trading .LLC\n'
                    'Dubai, United Arab Emirates \n'
                    'info@toplineuae.com\n',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: secondaryPurple),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/tpline.png',
                          width: 60.w,
                          height: 60.h,
                        ),
                        Image.asset(
                          'assets/DHA.png',
                          width: 60.w,
                          height: 60.h,
                        ),
                        Image.asset(
                          'assets/MOH.png',
                          width: 60.w,
                          height: 60.h,
                        ),
                        Image.asset(
                          'assets/DOH.png',
                          width: 60.w,
                          height: 60.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
