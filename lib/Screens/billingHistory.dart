import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/Models/billingModel.dart';
import 'package:topline/Constants/apis.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Constants/routes.dart';
import 'package:topline/Screens/appoinmentList.dart';
import 'package:topline/Screens/labReport.dart';
import 'package:topline/Screens/patientHistory.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/billing_provider.dart';

class Transaction extends StatefulWidget {
  Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  void initState() {
    _fetchingBillinData();
    super.initState();
  }

  List<BillingData> allBillingData = [];
  List<BillingData> filteredBillingData = [];
  TextEditingController searchController = TextEditingController();
  bool loading = false;

  Future<void> _fetchingBillinData() async {
    try {
      BillingDataService billingDataService =
          Provider.of<BillingDataService>(context, listen: false);
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      int userId = authProvider.userId;
      setState(() {
        loading = true;
      });
      List<BillingData> billingList = await billingDataService
          .getBillingTest(billingApi + userId.toString());
      setState(() {
        allBillingData = billingList;
        filteredBillingData = billingList;
        // print(obj);
        // print('111111111111111111111111111111111');
        loading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        loading = false;
      });
    }
  }

  void filterData() {
    final query = searchController.text.toLowerCase();
    final filtered = allBillingData.where((record) {
      final date = DateTime.parse(record.invoiceDate.toString()).toLocal();
      final formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      return formattedDate.contains(query);
    }).toList();

    setState(() {
      filteredBillingData =
          filtered; // Update filtered records based on the query
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(158, 158, 158, 1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
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
              const SizedBox(width: 20),
              Container(
                margin: const EdgeInsets.only(top: 1),
                child: Text(
                  "Billing History",
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Appoinment(),
                            ),
                          );
                        },
                        child:  CircleAvatar(
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
                            radius: 25.r,
                            backgroundColor: secondaryPurple,
                            child: Image.asset(
                              "assets/writing.png",
                              scale: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Text("Treatments",
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LabReport(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 25.r,
                            backgroundColor: secondaryPurple,
                            child: Image.asset(
                              "assets/comment.png",
                              scale: 20,
                              color: Colors.white,
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
                         CircleAvatar(
                          radius: 25.r,
                          backgroundColor: secondarylightPurple,
                          child: Image.asset(
                            "assets/credit-card.png",
                            scale: 20,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Text(
                          "Billing History",
                          style: TextStyle(
                              color: secondarylightPurple,
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
                  filterData(); // Filter records on text change
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
            const SizedBox(height: 15),
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
                  : Center(child: BillingList(obj: filteredBillingData)),
            ),
          ],
        ),
      ),
    );
  }
}

class BillingList extends StatefulWidget {
  const BillingList({
    super.key,
    required this.obj,
  });

  final List<BillingData> obj;

  @override
  State<BillingList> createState() => _BillingListState();
}

class _BillingListState extends State<BillingList> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    List<BillingData> sortedObj =
        List.from(widget.obj); // Create a copy of the list
    sortedObj.sort((a, b) => DateTime.parse(b.invoiceDate.toString()).compareTo(
        DateTime.parse(a.invoiceDate.toString()))); // Sort by createdDate
    if (sortedObj.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/empty_.png',
              scale: .010.sh,
              opacity: AlwaysStoppedAnimation(.5),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "No Bills",
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
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            itemCount: showMore ? sortedObj.length : min(sortedObj.length, 10),
            itemBuilder: (_, index) {
              DateTime date =
                  DateTime.parse(sortedObj[index].invoiceDate.toString());
              String formattedDate =
                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                  const aedSymbol = 'د.إ'; 
              return Container(
                
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 15.h),
                    child: ListTile(
                        onTap: () {
                          print("topline.computers$index");
                        },
                        leading: const CircleAvatar(
                          radius: 30,
                          backgroundColor: whitelightPurple,
                          child: Icon(
                            Icons.money,
                            color: white,
                          ),
                        ),
                        subtitle: Text(
                          formattedDate,
                          style: const TextStyle(color: Colors.black87),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "AED ${sortedObj[index].paidAmount}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: dred,
                                  fontSize: 16),
                            ),
                            Text(
                              "Bal: AED ${sortedObj[index].balance}",
                              style: const TextStyle(color: green, fontSize: 13),
                            ),
                          ],
                        ),
                        title: Text(
                          '${sortedObj[index].invoiceNumber}',
                          style: const TextStyle(
                            color: primaryPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
              );
            },
          ),
        ),
        if (!showMore)
          Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                setState(() {
                  showMore = true;
                });
              },
              child: const Text(
                "SHOW MORE",
                style: TextStyle(
                    color: secondaryPurple, fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}
