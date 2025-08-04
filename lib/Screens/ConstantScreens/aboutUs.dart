import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topline/Constants/colors.dart';

class AboutToplinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: white,
                  size: 0.06.sh,
                ),
              ),
            ),
            SizedBox(width: 0.05.w),
            Text(
              'About Us',
              style: GoogleFonts.afacad(
                color: white,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
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
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Who We Are ?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: secondaryPurple,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Topline IT Solutions is a well-known name in the field of providing comprehensive clinic software and IT infrastructure services globally. Based in Dubai, UAE, we cater to both small startups and large organizations across diverse industries.',
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Our Mission',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: secondaryPurple,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'At Topline IT Solutions, we are committed to understanding the specific business and technological needs of our clients. We strive to offer the best clinic software solutions that meet their individual requirements and enhance their business operations.',
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Our Vision',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: secondaryPurple,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Our vision is to become global leaders in providing technology-driven business solutions and services. We aim to achieve this while maintaining integrity and delivering exceptional value to our clients through ethical and strategic clinic software solutions.',
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: secondaryPurple,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Based in Dubai, UAE, Topline IT Solutions serves clients globally with a broad geographic reach.',
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Contact Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: secondaryPurple,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'For inquiries and more information, please contact us at:',
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Email: info@toplineuae.com\n',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    color: secondaryPurple,
                    fontWeight: FontWeight.bold,
                  ),
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
        ],
      ),
    );
  }
}
