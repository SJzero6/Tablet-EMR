import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/animation.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Constants/helperFunctions.dart';
import 'package:topline/Constants/routes.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/booking_provider.dart';
import 'package:topline/providers/slots_provider.dart';

class Slotspage extends StatefulWidget {
  final int docid;
  final String docName;
   const Slotspage({super.key, required this.docid, required this.docName});

  @override
  State<Slotspage> createState() => _SlotspageState();
}

class _SlotspageState extends State<Slotspage> with TickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDay = DateTime.now();
  String? selectedSlotTime;
  String? selectedSlotPeriod;
  List<String> lockedSlots = [];
  Map<DateTime, List<String>> lockedSlotsMap = {};

  final List<DateTime> days =
      List.generate(365, (index) => DateTime.now().add(Duration(days: index)));

  // File? _profileImage;
  // final ImagePicker _picker = ImagePicker();

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController.repeat();

    // _loadProfileImage();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _fetchTimeslots();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _fetchTimeslots() async {
    final provider = Provider.of<TimeslotProvider>(context, listen: false);
    Provider.of<AuthProvider>(context, listen: false);
    String selectedDateString = DateFormat('yyyy-MM-dd').format(_selectedDay);

    await provider.fetchTimeslots("${selectedDateString}T00:00:00",
        "${selectedDateString}T23:45:00", widget.docid.toString());
  }

  // void _lockSlot(String slot) {
  //   setState(() {
  //     if (!lockedSlotsMap.containsKey(_selectedDay)) {
  //       lockedSlotsMap[_selectedDay] = [];
  //     }

  //     lockedSlotsMap[_selectedDay]!.add(slot);
  //   });

  //   Future.delayed(const Duration(days: 1), () {
  //     setState(() {
  //       lockedSlotsMap[_selectedDay]!.remove(slot);
  //     });
  //   });
  // }

  bool _isSlotLocked(String slot) {
    if (lockedSlotsMap.containsKey(_selectedDay)) {
      return lockedSlotsMap[_selectedDay]!.contains(slot);
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeslotProvider>(context);
    String monthName =
        DateFormat.MMMM().format(DateTime(0, _selectedDay.month));
    final screenHeight = MediaQuery.of(context).size.height;
    //final screenWidth = MediaQuery.of(context).size.width;

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
              width: 0.05.w,
            ),
            Text(
              'Booking to\t${widget.docName}',
              style: GoogleFonts.afacad(
                fontSize: screenHeight * 0.02,
                color: white,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                         Text(
                          'Schedules',
                          style: TextStyle(
                              fontSize: screenHeight * 0.015,
                              fontWeight: FontWeight.bold,
                              color: primaryPurple),
                        ),
                        SizedBox(width: 10.w),
                        const Icon(
                          Icons.clear_all_outlined,
                          color: secondaryPurple,
                        )
                      ],
                    ),
                  ),
                  Text(
                    "$monthName ${_selectedDay.year.toString()}",
                    style:  TextStyle(
                        fontSize: screenHeight * 0.015,
                        fontWeight: FontWeight.bold,
                        color: primaryPurple),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.arrow_left_rounded,
                    color: secondaryPurple,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          final day = days[index];
                          bool isSelected = _selectedDay.year == day.year &&
                              _selectedDay.month == day.month &&
                              _selectedDay.day == day.day;

                          bool isToday = DateTime.now().year == day.year &&
                              DateTime.now().month == day.month &&
                              DateTime.now().day == day.day;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDay = day;
                                _fetchTimeslots();
                              });
                            },
                            child: Container(
                              width: 50.w,
                              height: 300.h,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                

                                border: isSelected
                                    ? Border.all(
                                        color: Colors.transparent, width: 2)
                                    : isToday
                                        ? Border.all(
                                            color: secondaryPurple, width: 2)
                                        : Border.all(
                                            color: Colors.transparent,
                                            width: 2),
                                gradient: isSelected
                                    ? const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          secondaryPurple,
                                          primarylightPurple,
                                          secondarylightPurple,
                                          secondaryPurple,
                                        ],
                                      )
                                    : isToday
                                        ? const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomRight,
                                            colors: [white, white])
                                        : const LinearGradient(colors: [
                                            whitelightPurple,
                                            whitelightPurple,
                                            whitelightPurple
                                          ]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('EEE').format(day),
                                      style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : primaryPurple,
                                              fontSize: screenHeight * 0.015,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      DateFormat('dd').format(day),
                                      style: TextStyle(
                                        fontSize:screenHeight * 0.015,
                                          color: isSelected
                                              ? Colors.white
                                              : primaryPurple,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_right_rounded,
                    color: secondaryPurple,
                  ),
                ],
              ),
              SizedBox(height: 15.h),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Choose Times',
                        style: TextStyle(
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.bold,
                            color: primaryPurple),
                      ),
                       Icon(Icons.align_vertical_center_rounded,
                          color: primaryPurple,size: 15.w,)
                    ],
                  ),
                  Icon(Icons.alarm,size: 15.w, color: primaryPurple)
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                margin: const EdgeInsets.all(5.0),
                height: 45.h,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TabBar(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
                  controller: _tabController,
                  indicator: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        // color: Color.fromRGBO(225, 95, 27, .3),
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      )
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          secondaryPurple,
                          primarylightPurple,
                          secondarylightPurple,
                          secondaryPurple,
                        ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: whitelightPurple,
                  unselectedLabelColor: whitelightPurple,
                  tabs:  [
                    Tab(
                      child: Text(
                        "Morning",
                        style: TextStyle(
                            color: white,
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Afternoon",
                        style: TextStyle(
                            color: white,
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Evening",
                        style: TextStyle(
                            color: white,
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 380.h, // Adjust height as needed
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(81, 40, 18, 0.298),
                          blurRadius: 10,
                          offset: Offset(10, 5),
                        )
                      ],
                      color: Colors.blueGrey[300],
                      borderRadius: BorderRadius.circular(20)),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildTimeSlots('Morning', provider.morningSlots),
                      buildTimeSlots('Afternoon', provider.afternoonSlots),
                      buildTimeSlots('Evening', provider.eveningSlots),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: ElevatedButton(
          onPressed:
              selectedSlotTime != null && !_isSlotLocked(selectedSlotTime!)
                  ? () {
                      String selectedDateString =
                          DateFormat('yyyy-MM-dd').format(_selectedDay);
                      _handleBookingAppointment();
                      _showSplashDialog(selectedSlotTime.toString(),
                          selectedDateString, selectedSlotPeriod.toString());
                    }
                  : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryPurple,
            shadowColor: secondarylightPurple,
            elevation: 10,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: Text(
            'CONFIRM & BOOK NOW',
            style: TextStyle(fontSize: .020.sh, color: white),
          ),
        ),
      ),
    );
  }

  Widget buildTimeSlots(String period, List<String> slots) {
    final provider = Provider.of<TimeslotProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight= MediaQuery.of(context).size.height;
    int crossAxisCount;
    if (screenWidth < 600) {
      crossAxisCount = 3;
    } else if (screenWidth < 900) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 5;
    }
    if (slots.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/noAppointments.gif',
              scale: 1.5.sp,
            ),
            Text(
              'No slots available for $period',
              style:  TextStyle(
                  fontSize: screenHeight * 0.015,
                  fontWeight: FontWeight.bold,
                  color: secondaryPurple),
            ),
          ],
        ),
      );
    } else {
      return Stack(
        children: [
          provider.loading
              ? Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/Loading.gif',
                      scale: 1.sp,
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 4,
                    childAspectRatio: 2,
                  ),
                  itemCount: slots.length,
                  itemBuilder: (context, index) {
                    final slot = slots[index];
                    final isLocked = _isSlotLocked(slot);
                    return FadeAnimation(
                      1,
                      GestureDetector(
                        onTap: () {
                          if (!isLocked) {
                            setState(() {
                              selectedSlotTime = slot;
                              selectedSlotPeriod = period;
                            });
                          }
                        },
                        child: Chip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(color: secondaryPurple)),
                          backgroundColor: isLocked
                              ? secondaryPurple
                              : selectedSlotTime == slot
                                  ? secondaryPurple
                                  : Colors.white,
                          label: Text(
                            slot,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.015,
                              color: isLocked
                                  ? Colors.black
                                  : selectedSlotTime == slot
                                      ? Colors.white
                                      : whitelightPurple,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ],
      );
    }
  }

  _handleBookingAppointment() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    String selectedDateString = DateFormat('yyyy-MM-dd').format(_selectedDay);
    String selectedDay = "$selectedDateString $selectedSlotTime";
    String doctorId = widget.docid.toString();
    String patientId = authProvider.userId.toString();

    final response =
        await Provider.of<SlotBookingProvider>(context, listen: false)
            .bookAppointment(selectedDay, doctorId, patientId);

    if (response.statusCode == 200) {
      showTextSnackBar(
          context, 'Time slot is booked for $selectedDay\t$selectedSlotTime');
    } else if (response.statusCode == 400 &&
        response.body.contains('Time slot already booked')) {
      showTextSnackBar(context, 'Time slot already booked');
    } else {
      showTextSnackBar(context, 'Contact The clinic');
    }
  }

  void _showSplashDialog(String time, String date, String period) {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/Loading.gif',
                          scale: 1.sp,
                        ),
                      ),
                      Text(
                        "Your Appoinment is booking for",
                        style: GoogleFonts.montserrat(
                            textStyle:
                                const TextStyle(color: secondarylightPurple)),
                      ),
                      Text(
                        date,
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: secondarylightPurple,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        "at $time $period",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: secondarylightPurple,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              );
            });
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  content: SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.done,
                          color: secondarylightPurple,
                          size: 50,
                        ),
                        Text(
                          "Your Appoinment is booked for",
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(color: primaryPurple)),
                        ),
                        Text(
                          date,
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  color: secondarylightPurple,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          "at $time $period",
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  color: secondarylightPurple,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryPurple),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.appointments,
                                (Route<dynamic> navi) => false,
                              );
                            },
                            child: const Text('View Appoinments',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                );
              });
        });
      },
    );

    // Dismiss the dialog after 3 seconds
  }
}
