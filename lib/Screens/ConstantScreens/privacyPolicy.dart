import 'package:flutter/material.dart';
import 'package:topline/Constants/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyNoticePage extends StatelessWidget {
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
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: secondarylightPurple,
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
                "Privacy Policy",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 0.02.sh,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Notice',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryPurple),
            ),
            const SizedBox(height: 16),
            const Text(
              'Last updated October 22, 2024',
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: primaryPurple),
            ),
            const SizedBox(height: 16),
            const Text(
              "This Privacy Notice for Topline Computer Trading LLC ('we', 'us', or 'our') "
              "describes how and why we might access, collect, store, use, and/or share "
              "('process') your personal information when you use our services ('Services'), including:",
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(
                'Download and use our mobile application (TABLET EMR), or any other application that links to this Privacy Notice.'),
            _buildBulletPoint(
                'Use Tablet EMR to book doctor appointments, view treatment details, check billing, and access lab reports.'),
            _buildBulletPoint(
                'Engage with us through sales, marketing, or events.'),
            const SizedBox(height: 16),
            const Text(
              'Summary of Key Points',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryPurple),
            ),
            const SizedBox(height: 16),
            _buildSectionHeader('What personal information do we process?'),
            _buildContentText(
                "We process personal information depending on how you interact with our Services. "
                "Learn more about the personal information you disclose to us."),
            _buildSectionHeader(
                'Do we process any sensitive personal information?'),
            _buildContentText(
                "Some information may be considered 'special' or 'sensitive' in certain jurisdictions. "
                "We process this information with your consent or as required by law."),
            _buildSectionHeader(
                'Do we collect information from third parties?'),
            _buildContentText(
                'We do not collect any information from third parties.'),
            // Add more sections as needed...
            const SizedBox(height: 16),
            const Text(
              "If you still have any questions or concerns, please contact us at:",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: primaryPurple),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                // You can link to an email action here
              },
              child: const Text(
                "info@toplineuae.com",
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: primaryPurple),
      ),
    );
  }

  Widget _buildContentText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text),
    );
  }
}
