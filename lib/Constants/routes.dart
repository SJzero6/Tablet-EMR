import 'package:flutter/material.dart';
import 'package:topline/Constants/navigationbar/navBar.dart';
import 'package:topline/Screens/Credentials/login.dart';
import 'package:topline/Screens/Credentials/signup.dart';
import 'package:topline/Screens/account.dart';
import 'package:topline/Screens/appoinmentList.dart';
import 'package:topline/Screens/billingHistory.dart';
import 'package:topline/Screens/doctorsList.dart';

import 'package:topline/Screens/home.dart';
import 'package:topline/Screens/labReport.dart';
import 'package:topline/Screens/patientHistory.dart';
import 'package:topline/Screens/splash.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String navi = '/navi';
  static const String appointments = '/appointments';
  static const String doctors = '/doctor';
  static const String labReport = '/labReport';
  static const String billingData = '/billingData';
  static const String patientHistory = '/patientHistory';
  static const String bookingpage = '/slotspage';
  static const String accountpage = '/account';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const Splash(),
    login: (context) => const LoginPage(),
    signup: (context) => const SignupPage(),
    home: (context) => const HomePage(),
    navi: (context) => const NavBarScreen(),
    appointments: (context) => Appoinment(),
    doctors: (context) => Doctors(),
    labReport: (context) => const LabReport(),
    billingData: (context) => Transaction(),
    patientHistory: (context) => PatientRecord(),
   // bookingpage: (context) => const Slotspage(docid: doc,),
    accountpage: (context) => const AccountPage(),
  };
}
