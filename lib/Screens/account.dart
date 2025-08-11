// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Screens/ConstantScreens/aboutUs.dart';
import 'package:topline/Screens/ConstantScreens/termsConditons.dart';
import 'package:topline/Screens/Credentials/login.dart';
import 'package:topline/Screens/appoinmentList.dart';
import 'package:topline/Screens/billingHistory.dart';
import 'package:topline/Screens/labReport.dart';
import 'package:topline/Screens/patientHistory.dart';
import 'package:topline/Screens/patientProfile.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:topline/Screens/ConstantScreens/privacyPolicy.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('UserId');
  }

  final List<Map<String, dynamic>> items = [
    {
      'title': 'View Profile',
      'icon': Icon(
        Icons.person_pin,
        color: secondaryPurple,
      )
    },
    {
      'title': 'Privacy Policy',
      'icon': Icon(Icons.privacy_tip_rounded, color: secondaryPurple)
    },
    {
      'title': 'Terms & Conditions',
      'icon': Icon(Icons.description, color: secondaryPurple)
    },
    {'title': 'About Us', 'icon': Icon(Icons.info, color: secondaryPurple)},
    {
      'title': 'Logout',
      'icon': Icon(Icons.logout_rounded, color: secondaryPurple)
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Abolfazl
    // var userId = storage.getItem('UserId');

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    //final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h), // Height of the AppBar
        child: Container(
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
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 200.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(80),
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
                    padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${authProvider.username} >",
                          style: TextStyle(
                              letterSpacing: 2,
                              color: Colors.white,
                              fontSize: .02.sh,
                              fontWeight: FontWeight.w900),
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Appoinment()));
                            },
                            child: CircleAvatar(
                              radius: 18.w,
                              backgroundColor: white,
                              child: Icon(
                                size: 15.w,
                                Icons.calendar_month,
                                color: secondaryPurple,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Appointments",
                              style: TextStyle(
                                  color: white,
                                  fontSize: screenHeight * 0.015,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientRecord(),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 18.w,
                              backgroundColor: white,
                              child: Image.asset(
                                "assets/writing.png",
                                scale: 20,
                                color: secondaryPurple,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Treatments",
                              style: TextStyle(
                                  color: white,
                                   fontSize: screenHeight * 0.015,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LabReport(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 18.w,
                              backgroundColor: white,
                              child: Image.asset(
                                "assets/comment.png",
                                scale: 20,
                                color: secondaryPurple,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Reports",
                                style: TextStyle(
                                    color: white,
                                     fontSize: screenHeight * 0.015,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Transaction(),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 18.w,
                              backgroundColor: white,
                              child: Icon(
                                Icons.payment,
                                color: secondaryPurple,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Billing History",
                            style: TextStyle(
                                color: white,
                                 fontSize: screenHeight * 0.015,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              margin: EdgeInsets.only(left: 0, top: 10, right: 10),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      opacity: const AlwaysStoppedAnimation(.4),
                    ),
                  ),
                  ListView(
                    children: items.map((item) {
                      return _buildAnimatedCard(
                        context,
                        title: item['title'],
                        icon: item['icon'],
                        onTap: () {
                          _handleTap(context, item['title']);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showLogOutAccountDialog(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: white,
          title: Text(
            'Logout Account',
            style:
                GoogleFonts.montserrat(textStyle:  TextStyle(color: red,fontSize:screenHeight * 0.015,)),
          ),
          content: Text(
            'Are you sure you want to Logout your account? This action cannot be undone.',
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(color: secondaryPurple)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: secondaryPurple),
              ),
            ),
            TextButton(
              onPressed: () {
                _logout(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route route) => false);
              },
              child: Text('LogOut',
                  style: TextStyle(
                    color: dred,
                  )),
            ),
          ],
        );
      },
    );
  }

  void _handleTap(BuildContext context, String title) {
    
    switch (title) {
      case 'View Profile':
        _showAccountDialog(context);

        break;
      case 'Privacy Policy':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PrivacyNoticePage()));
        break;
      case 'Terms & Conditions':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
        break;
      case 'About Us':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AboutToplinePage()));
        break;
      case 'Logout':
        // Call a function to handle logout logic here
        showLogOutAccountDialog(context);

        break;
    }
  }

  Widget _buildAnimatedCard(
    
  BuildContext context, {
  required String title,
  required Icon icon,
  required VoidCallback onTap,
}) {
  return PlayAnimationBuilder<double>(
    duration: Duration(milliseconds: 500),
    delay: Duration(milliseconds: 100),
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(10.w, 100.h * (1 - value)), // Responsive offset
        child: Transform.scale(
          scale: 1 + (value * 0.1),
          child: Opacity(
            opacity: value,
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 20.w,
              ), // Responsive margins
              child: ListTile(
                trailing: icon,
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.015, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: primaryPurple,
                  ),
                ),
                onTap: onTap,
              ),
            ),
          ),
        ),
      );
    },
  );
  }

  void _showAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account Information'),
          content: Text(
            'To update or delete your account in the Tablet EMR mobile application, you would typically need to contact the clinic.',
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to profile page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewProfile()));
                },
                child: Text('Go to Profile', style: TextStyle(color: green))),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel', style: TextStyle(color: secondaryPurple)),
            ),
          ],
        );
      },
    );
  }
}
