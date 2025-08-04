import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:topline/Constants/routes.dart';

//import 'package:dermaklinic/navbar/navBar.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _navigatetohome();
    super.initState();
  }

  _navigatetohome() {
    Future.delayed(const Duration(milliseconds: 4500), () {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/topline.gif",
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
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
    );
  }
}
