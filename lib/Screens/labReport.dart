import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/animation.dart';
import 'package:topline/Constants/apis.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Constants/routes.dart';
import 'package:topline/Screens/patientHistory.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/labReport_provider.dart';

class LabReport extends StatefulWidget {
  const LabReport({super.key});

  @override
  State<LabReport> createState() => _LabReportState();
}

late TabController _tabController;
String searchQuery = '';

class _LabReportState extends State<LabReport> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                "Medical Report",
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
                      child: const CircleAvatar(
                        radius: 28,
                        backgroundColor: secondaryPurple,
                        child: Icon(
                          Icons.calendar_month,
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
                          radius: 28,
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
                      const Text("Treatments",
                          style: TextStyle(
                              color: secondaryPurple,
                              fontSize: 12,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: secondarylightPurple,
                        child: Image.asset(
                          "assets/comment.png",
                          scale: 20,
                          color: white,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text("Reports",
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
                              context, AppRoutes.billingData);
                        },
                        child: const CircleAvatar(
                          radius: 28,
                          backgroundColor: secondaryPurple,
                          child: Icon(
                            Icons.payment,
                            color: Colors.white,
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
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 10, bottom: 10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                  hintText: 'Search by Order Name or Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: secondaryPurple,
                        width: 2.0,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: secondaryPurple,
                        width: 2.0,
                      ))),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            height: 40.h,
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
              tabs: const [
                Tab(
                  child: Text(
                    "Lab Report",
                    style: TextStyle(
                        color: white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Radiology Report",
                    style: TextStyle(
                        color: white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                FadeAnimation(
                    1.0,
                    ListBuilder(
                      searchQuery: searchQuery,
                      fileTypeFilter: 'Lab',
                    )),
                FadeAnimation(
                    1.0,
                    ListBuilder(
                      searchQuery: searchQuery,
                      fileTypeFilter: 'Radiology',
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListBuilder extends StatefulWidget {
  final String searchQuery;
  final String fileTypeFilter;

  ListBuilder(
      {Key? key, required this.searchQuery, required this.fileTypeFilter})
      : super(key: key);

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    LabReportService labReportService =
        Provider.of<LabReportService>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    int userId = authProvider.userId;

    return Column(
      children: [
        Expanded(
            child: FutureBuilder<List<Map<String, String>>>(
                future: labReportService.fetchBase64StringsAndOrderNames(
                    pdfViewApi + userId.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/Loading.gif',
                          scale: 1.sp,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<Map<String, String>> data = snapshot.data ?? [];

                    // Filter data based on search query
                    List<Map<String, String>> filteredData = data.where((item) {
                      String orderName = item['orderName']?.toLowerCase() ?? '';
                      String createDate =
                          item['createDate']?.toLowerCase() ?? '';
                      String fileType = item['FileType']?.toLowerCase() ?? '';

                      // Filter by FileType (Lab or Radiology)
                      bool matchesFileType =
                          fileType == widget.fileTypeFilter.toLowerCase();

                      // Filter by search query
                      bool matchesSearchQuery =
                          orderName.contains(widget.searchQuery) ||
                              createDate.contains(widget.searchQuery);

                      return matchesFileType && matchesSearchQuery;
                    }).toList();
                    if (filteredData.isEmpty) {
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
                              "No Reports",
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
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final item = filteredData[index];
                          DateTime date =
                              DateTime.parse(item['createDate'].toString());
                          String formattedDate =
                              "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                          return Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                  onTap: () {
                                    labReportService.previewPDF(
                                        context,
                                        item['base64String'] ?? 'null',
                                        item['orderName'] ?? '',
                                        item['createDate'] ?? '');
                                  },
                                  leading: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: whitelightPurple,
                                    child: Icon(
                                      Icons.paste_rounded,
                                      color: white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    formattedDate,
                                    style:
                                        const TextStyle(color: Colors.black38),
                                  ),
                                  trailing: const Icon(
                                    Icons.keyboard_double_arrow_right_rounded,
                                    color: secondaryPurple,
                                  ),
                                  title: Text(
                                    item['orderName'] ?? '',
                                    style: const TextStyle(
                                      color: primaryPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          );
                        });
                  }
                })),
      ],
    );
  }
}
