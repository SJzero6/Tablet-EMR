import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/Models/patientHistoryModel.dart';
import 'package:topline/Constants/apis.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Constants/helperFunctions.dart';
import 'package:topline/Constants/routes.dart';
import 'package:topline/Screens/treatmentList.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/patientHistory_provider.dart';

class PatientRecord extends StatefulWidget {
  PatientRecord({super.key});

  @override
  State<PatientRecord> createState() => _PatientRecordState();
}

class _PatientRecordState extends State<PatientRecord> {
  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  bool loading = false;
  List<RecentTreatmentData> allRecords = []; // Complete list of records
  List<RecentTreatmentData> filteredRecords = []; // Filtered results
  TextEditingController searchController = TextEditingController();

  Future<void> _fetchData() async {
    try {
      PatientHistoryService patientHistory =
          Provider.of<PatientHistoryService>(context, listen: false);
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      int userId = authProvider.userId;

      setState(() {
        loading = true;
      });

      List<RecentTreatmentData> treatmentList = await patientHistory
          .getTreatmentList(context, patientHistorytAPI + userId.toString());

      if (mounted) {
        setState(() {
          allRecords = treatmentList;
          filteredRecords = treatmentList; // Initialize filtered list
          loading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void filterDoctors() {
    final query = searchController.text.toLowerCase();
    final filtered = allRecords.where((record) {
      final doctorName = (record.doctorName?.toLowerCase());
      final date = DateTime.parse(record.createdDate.toString()).toLocal();
      final formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      return (doctorName!.contains(query)) || formattedDate.contains(query);
    }).toList();

    setState(() {
      filteredRecords = filtered; // Update filtered records based on the query
    });
  }

  bool showMore = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(158, 158, 158, 1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
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
            const SizedBox(width: 20),
            Container(
              margin: const EdgeInsets.only(top: 1),
              child: Text(
                "Patient History",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 0.02.sh,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.appointments);
                      },
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: secondaryPurple,
                        child: Image.asset(
                          "assets/calendar.png",
                          scale: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text("Appointments",
                        style: TextStyle(
                            color: secondaryPurple,
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: secondarylightPurple,
                        child: Image.asset(
                          "assets/writing.png",
                          scale: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text("Treatments",
                          style: TextStyle(
                              color: secondarylightPurple,
                              fontSize: screenHeight * 0.015,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.labReport);
                        },
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundColor: secondaryPurple,
                          child: Image.asset(
                            "assets/comment.png",
                            scale: 20,
                            color: white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text("Reports",
                          style: TextStyle(
                              color: secondaryPurple,
                              fontSize: screenHeight * 0.015,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.billingData);
                        },
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundColor: secondaryPurple,
                          child: Image.asset(
                            "assets/credit-card.png",
                            scale: 20,
                            color: white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        "Billing History",
                        style: TextStyle(
                            color: secondaryPurple,
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterDoctors(); // Filter records on text change
              },
              decoration: InputDecoration(
                hintText: 'Search by doctor name or date',
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
                : ReportListView(obj: filteredRecords),
          ),
        ],
      ),
    );
  }
}

class ReportListView extends StatelessWidget {
  const ReportListView({
    Key? key,
    required this.obj,
  }) : super(key: key);

  final List<RecentTreatmentData> obj;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    //final screenWidth = MediaQuery.of(context).size.width;
    
    List<RecentTreatmentData> sortedObj =
        List.from(obj); 
    sortedObj.sort((a, b) => DateTime.parse(b.createdDate.toString()).compareTo(
        DateTime.parse(a.createdDate.toString())));
    if (sortedObj.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/empty_.png',
              scale: .010.sh,
              opacity: const AlwaysStoppedAnimation(.5),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "No Treatment history",
              style: TextStyle(
                fontSize: 0.025.sh,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast),
      itemCount: sortedObj.length,
      itemBuilder: (context, index) {
        DateTime date = DateTime.parse(sortedObj[index].createdDate.toString());
        String formattedDate =
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

        DateTime dateTime =
            DateTime.parse(sortedObj[index].startTime.toString());

        String period = dateTime.hour >= 12 ? 'PM' : 'AM';
        int hour = dateTime.hour % 12;
        hour = hour == 0 ? 12 : hour;

        String formattedTime =
            '${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';

        DateTime endTime = DateTime.parse(sortedObj[index].endTime.toString());

        String endPeriod = endTime.hour >= 12 ? 'PM' : 'AM';
        int endHour = endTime.hour % 12;
        endHour = endHour == 0 ? 12 : endHour;

        String formattedEndTime =
            '${endHour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')} $endPeriod';
        bool _ispast=endTime.isBefore(DateTime.now());
        return Container(
            height: .15.sh,
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: // Refactored Card with Left Accent
                Card(shadowColor: secondaryPurple,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  _ispast?
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccordionExample(
                        idData: sortedObj[index].id,
                      ),
                    ),
                  ):DialogHelper.showCustomAlertDialog(context, "Your Appoinment is not Done", "assets/no-data.gif");
                },
                child: Row(
                  children: [
                    
                    Container(
                      width: 10.w,
                      height: screenHeight.h, 

                      decoration:  BoxDecoration(
                        //color: primarylightPurple,
                        color: _ispast ? green: blue,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                    ),
                    // The main content area.
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.0.w, vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${sortedObj[index].doctorName}",
                              style: TextStyle(
                                color: primaryPurple,
                                fontSize: screenHeight*0.018,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: screenHeight * 0.015,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              "Start Time: $formattedTime",
                              style: TextStyle(
                                color: green,
                                fontSize: screenHeight * 0.015,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              "End Time: $formattedEndTime",
                              style: TextStyle(
                                color: dred,
                                fontSize: screenHeight * 0.015,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: primarylightPurple,
                        size: 30.h,
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
