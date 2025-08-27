import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/Models/doctorModel.dart';
import 'package:topline/Constants/animation.dart';
import 'package:topline/Constants/apis.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Constants/routes.dart';
import 'package:topline/Screens/appoinmentList.dart';
import 'package:topline/Screens/slotsPage.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/doctor_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Doctors extends StatefulWidget {
  Doctors({Key? key});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  bool loading = false;

  Future<void> _fetchData() async {
    try {
      DoctorProvider doctorProvider =
          Provider.of<DoctorProvider>(context, listen: false);

      if (this.mounted) {
        setState(() {
          loading = true;
        });
      }
      List<DoctorData> obj =
          await doctorProvider.getDoctorData(AuthProvider(), doctorsAPI);

      //await storage.setItem('Id', obj[index].id);

      if (this.mounted) {
        setState(() {
          this.obj = obj;
          loading = false;
        });
      }
    } catch (e) {
      if (this.mounted) {
        setState(() {
          loading = false;
        });
      }
      print('Error fetching data: $e');
    }
  }

  //     DoctorName: 'DoctorName', DoctorDepartment: 'DoctorDepartment');

  List<DoctorData> obj = [];

  TextEditingController searchController = TextEditingController();

  void filterDoctors() {
    String query = searchController.text.toLowerCase();
    setState(() {
      obj = obj
          .where((doctor) =>
              (doctor.doctorName?.toLowerCase() ?? '').contains(query) ||
              (doctor.doctorDepartment?.toLowerCase() ?? '').contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            ),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: screenHeight * 0.08,
          backgroundColor: secondarylightPurple,
          title: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 1),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.navi);
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
                width: screenWidth * 0.05,
              ),
              Container(
                margin: const EdgeInsets.only(top: 1),
                child: Text(
                  "Doctors & Specialists",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  filterDoctors();
                },
                decoration: InputDecoration(
                  hintText: 'Search doctors...',
                  prefixIcon: const Icon(Icons.search, color: blue),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                        color: secondaryPurple, width: 2.0), // Red border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                        color: secondaryPurple,
                        width: 2.0), // Red border for enabled state
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                        color: secondaryPurple,
                        width: 2.0), // Red border when focused
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      opacity: const AlwaysStoppedAnimation(.4),
                    ),
                  ),
                  Positioned.fill(
                    child: loading
                        ? Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                'assets/Loading.gif',
                                scale: 1.sp,
                              ),
                            ),
                          )
                        : FadeAnimation(
                            0.1,
                            Listview(
                              obj: obj,
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              //tabIndex: _tabController.index,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Listview extends StatefulWidget {
  const Listview({
    super.key,
    required this.obj,
    required this.screenHeight,
    required this.screenWidth,
    // required this.tabIndex
  });

  final List<DoctorData> obj;
  final double screenHeight;
  final double screenWidth;
  // final int tabIndex;

  @override
  State<Listview> createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
  void _makePhoneCall() async {
    const phoneNumber = 'tel:0569482058';

    try {
      await launchUrl(Uri.parse(phoneNumber));
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // var session = SessionNext();
    // session.set('doctorId', widget.obj[index].id);

    return ListView.builder(
      physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast),
      itemCount: widget.obj.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.all(widget.screenHeight * 0.017),
              height: widget.screenHeight * 0.15,
              width: widget.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.screenHeight * 0.05),
              ),
              child: GestureDetector(
                onTap: () {
                  final doctorname=widget.obj[index].doctorName ?? 'Doctor';
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  Slotspage(docid: widget.obj[index].id, docName:doctorname,),
                      ));
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(widget.screenHeight * 0.025),
                  ),
                  elevation: 10,
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: widget.screenHeight * 0.01),
                              child: CircleAvatar(
                                  radius: widget.screenHeight * .055,
                                  foregroundImage: const AssetImage(
                                    'assets/user.png',
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: widget.screenWidth * 0.01),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.obj[index].doctorName}',
                                    style: TextStyle(
                                      fontSize: widget.screenHeight * 0.015,
                                      color: primaryPurple,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "${widget.obj[index].experiance} of Experience",
                                    style: TextStyle(
                                      fontSize: widget.screenHeight * 0.015,
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: widget.screenWidth * 0.4,
                                    height: widget.screenHeight * 0.03,
                                    decoration: BoxDecoration(
                                      color: primarylightPurple,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Specialist ${widget.obj[index].doctorDepartment}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: widget.screenHeight * 0.012,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widget.screenWidth * 0.5,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: widget.screenHeight * 0.02,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: widget.screenHeight * 0.02,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: widget.screenHeight * 0.02,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: widget.screenHeight * 0.02,
                                        ),
                                        Icon(
                                          Icons.star_half,
                                          color: Colors.amber,
                                          size: widget.screenHeight * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: widget.screenHeight * .09,
                              width: widget.screenWidth *.09,
                              decoration: const BoxDecoration(
                                  color: secondaryPurple,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10))),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Appoinment()),
                                    );
                                  },
                                  icon:  Icon(
                                    size: 15.w,
                                    Icons.calendar_month,
                                    color: white,
                                  )),
                            ),
                            Container(
                                height: widget.screenHeight * .09,
                                width: widget.screenWidth *.09,
                                decoration: const BoxDecoration(
                                    color: secondarylightPurple,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10))),
                                child: IconButton(
                                    onPressed: () {
                                      _makePhoneCall();
                                    },
                                    icon:  Icon(
                                      size: 15.w,
                                      Icons.phone,
                                      color: Colors.white,
                                    ))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
