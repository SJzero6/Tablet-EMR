// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Screens/account.dart';
import 'package:topline/Screens/appoinmentList.dart';
import 'package:topline/Screens/doctorsList.dart';
import 'package:topline/Screens/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({
    Key? key,
  }) : super(key: key);

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
      AccountPage()
      // TablePage1(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: (50.h <= 75.0) ? 50.h : 75.0,
        // selectedItemColor: blue,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: secondaryPurple,
        color: secondaryPurple,
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
          Image.asset('assets/home.png', scale: 12.0),

          Image.asset('assets/calendarlines.png', scale: 5.0),

          Image.asset(
            'assets/doctor.png',
            scale: 17.0,
            color: white,
          ),

          Image.asset('assets/user.png', scale: 5.0),

          // BottomNavigationBarItem(
          //     icon: Icon(Icons.book),
          //     label: 'Booklet',
          //     backgroundColor: naviblue),
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
