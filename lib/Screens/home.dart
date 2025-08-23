import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/Models/doctorModel.dart';
import 'package:topline/Constants/apis.dart';
import 'package:topline/Constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:topline/Constants/routes.dart';
import 'package:topline/Screens/labReport.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/doctor_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _fetchDoctorData();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Runes wavingHand = Runes('\u{1F44B}');
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h), // Height of the AppBar
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  secondaryPurple,
                  primarylightPurple,
                  secondarylightPurple,
                  secondaryPurple,
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 160.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(140),
              ),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
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
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hello..${String.fromCharCodes(wavingHand)}",
                        style: TextStyle(
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Image.asset(
                        'assets/Tencate.png', // Path to your image
                        height: 50.h, // Adjust the height
                        width: 50.w,
                        // Adjust the width
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    '${authProvider.username}',
                    style: GoogleFonts.tiltNeon(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Welcome to the world of possibilities",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _cardmenu(
                    title: 'Specialist',
                    asset: 'assets/doctor.png',
                    color: Colors.cyan,
                    fontcolor: Colors.white,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.doctors);
                    },
                  ),
                  _cardmenu(
                    title: 'Appointments',
                    asset: 'assets/appoint.png',
                    color: Colors.amber,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.appointments);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _cardmenu(
                    title: 'Treatments',
                    asset: 'assets/writing.png',
                    color: const Color.fromARGB(255, 255, 155, 188),
                    fontcolor: Colors.white,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.patientHistory);
                    },
                  ),
                  _cardmenu(
                    title: "Reports           ",
                    asset: "assets/comment.png",
                    color: const Color.fromARGB(255, 109, 192, 192),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LabReport(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Doctors",
                  style: GoogleFonts.abel(fontSize: 24.sp),
                ),
                Image.asset(
                  'assets/medical-team.png',
                  scale: 4.r,
                )
              ],
            ),
          ),
          Center(
            child: loading
                ? SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: Image.asset(
                      'assets/Loading.gif',
                      scale: 1.r,
                    ),
                  )
                : CarouselSlider(
                    options: CarouselOptions(
                      height: 300.h, // Adjusted for image + text
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.6,
                      aspectRatio: 15 / 8,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      initialPage: 0,
                    ),
                    items: doctorData.map((item) {
                      return Stack(
                        children: [
                          // Image
                          Container(
                            decoration: BoxDecoration(
                              color: secondaryPurple,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5.r,
                                  blurRadius: 10.r, 
                                  offset: Offset(
                                      0, 3.h), 
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r), // responsive
                                topRight: Radius.circular(20.r),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r), // responsive
                                topRight: Radius.circular(10.r),
                              ),
                              child: Image.asset(
                                'assets/doctor.png',
                                color: white,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: 200.h, // responsive height
                              ),
                            ),
                          ),

                          // Text Container Overlay
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(10.r), // responsive
                                  bottomRight: Radius.circular(10.r),
                                ),
                                color: white.withOpacity(0.8),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 15.h, // responsive padding
                                horizontal: 10.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item.doctorName}',
                                    style: TextStyle(
                                      fontSize: 18.sp, // responsive font
                                      fontWeight: FontWeight.bold,
                                      color: primaryPurple,
                                    ),
                                  ),
                                  SizedBox(height: 5.h), // responsive spacing
                                  Text(
                                    '${item.doctorDepartment}',
                                    style: TextStyle(
                                      fontSize: 14.sp, // responsive font
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _cardmenu({
    required String title,
    required asset,
    required onTap,
    Color color = Colors.white,
    Color fontcolor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: 165.sp,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(24),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35.h,
              width: 30.w,
              child: Image.asset(
                asset,
                color: Colors.white,
                scale: 10,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: fontcolor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool loading = false;

  void _fetchDoctorData() async {
    try {
      final doctorProvider =
          Provider.of<DoctorProvider>(context, listen: false);
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);

      setState(() {
        loading = true;
      });

      List<DoctorData> data =
          await doctorProvider.getDoctorData(authProvider, doctorsAPI);

      setState(() {
        doctorData = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  List<DoctorData> doctorData = [];
}
