// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Screens/account.dart';
import 'package:topline/Screens/appoinmentList.dart';
import 'package:topline/Screens/doctorsList.dart';
import 'package:topline/Screens/home.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  _NavBarScreenState() {
    _screens = [
      HomePage(),
      Appoinment(),
      Doctors(),
      AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 50.h.clamp(50.0, 75.0), // responsive height with min/max
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: secondaryPurple,
        color: secondaryPurple,
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
          Image.asset(
            'assets/home.png',
            width: 24.w, // responsive width
            height: 24.h, // responsive height
          ),
          Image.asset(
            'assets/calendarlines.png',
            width: 24.w,
            height: 24.h,
          ),
          Image.asset(
            'assets/doctor.png',
            width: 24.w,
            height: 24.h,
            color: white,
          ),
          Image.asset(
            'assets/user.png',
            width: 24.w,
            height: 24.h,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
