import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/Models/patientProfileModel.dart';
import 'package:topline/Constants/Widgets/resetpasswordDailogBox.dart';
import 'package:topline/Constants/apis.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/patientProfile_provider.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  void initState() {
    _fetchProfileData();
    super.initState();
  }

  List<ProfileData> obj = [];

  bool loading = false;

  Future<void> _fetchProfileData() async {
    try {
      ProfileService profileService =
          Provider.of<ProfileService>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.userId.toString();
      setState(() {
        loading = true;
      });

      // Use ProfileData instead of List<ProfileData>
      ProfileData? patientData = await profileService
          .getPatientProfileData(patientProfileApi + userId);

      // Check if patientData is not null before updating the state
      if (patientData != null) {
        setState(() {
          obj = [patientData]; // Store the single ProfileData object in a list
          loading = false;
        });
      } else {
        // Handle the case where patientData is null
        print('Error: Unable to fetch patient data');
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print('Error fetching data: $e');
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
  
    
    return Scaffold(
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
  toolbarHeight: 80,
  title: Row(
    children: [
      Container(
        margin: const EdgeInsets.only(top: 1),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: Image.asset(
              "assets/back-arrow.png",
              scale: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      const SizedBox(width: 20),
      Container(
        margin: const EdgeInsets.only(top: 1),
        child: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.02,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
  actions: [
    PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onSelected: (value) {
        if (value == 'reset_password') {
          // Handle reset password action here
          ForgotPasswordDialog.showEmailDialog(context);
          // For example, show a dialog or navigate to reset password screen
          print(obj[0].eid);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'reset_password',
          child: Text('Reset Password'),
        ),
      ],
    ),
  ],

      ),
      body: SingleChildScrollView(
        child: loading
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      'assets/Loading.gif',
                      scale: 1.sp,
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: SizedBox(
                      child: Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 3, color: secondaryPurple)),
                                child: CircleAvatar(
                                    radius: 45,
                                    backgroundColor: Colors.grey[200],
                                    foregroundImage: const AssetImage(
                                      'assets/user.png',
                                    )
                                    // backgroundImage: NetworkImage(
                                    //     "${obj.isNotEmpty ? obj[0].profilePhoto : 'https://www.pngmart.com/files/10/User-Account-Person-PNG-File.png'}")),
                                    )),
                          ),
                          SizedBox(
                            width: screenWidth * 0.018,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${obj.isNotEmpty ? obj[0].name : 'N/A'}",
                                style: TextStyle(
                                    fontSize: screenHeight * 0.020,
                                    fontWeight: FontWeight.bold,
                                    color: primaryPurple),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 20,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: green,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(
                                    child: Text(
                                  "verified",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        left: screenWidth * 0.04,
                                        top: screenHeight * 0.02),
                                    child: const Text(
                                      "Mobile Number",
                                      style: TextStyle(color: Colors.black54),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: screenWidth * 0.04,
                                        top: screenHeight * 0.01),
                                    child: Text(
                                      "${obj.isNotEmpty ? obj[0].number : 'N/A'}",
                                      style: const TextStyle(
                                          color: secondarylightPurple,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          right: screenWidth * 0.04,
                                          top: screenHeight * 0.02),
                                      child: const Text(
                                        "Date Of Birth",
                                        style: TextStyle(color: Colors.black54),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(
                                          right: screenWidth * 0.05,
                                          top: screenHeight * 0.01),
                                      child: Text(
                                        "${obj.isNotEmpty ? obj[0].dob : 'N/A'}",
                                        style: const TextStyle(
                                            color: secondarylightPurple,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: screenWidth * 0.04,
                              top: screenHeight * 0.02),
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Email Address",
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              Text(
                                "${obj.isNotEmpty ? obj[0].email : 'Nil'}",
                                style: const TextStyle(
                                    color: secondarylightPurple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: screenWidth * 0.04,
                              top: screenHeight * 0.02),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Gender",
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                "${obj.isNotEmpty ? obj[0].gender : 'N/A'}",
                                style: const TextStyle(
                                    color: secondarylightPurple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                      left: screenWidth * 0.04,
                                      top: screenHeight * 0.02,
                                    ),
                                    child: const Text(
                                      "Visa Status",
                                      style: TextStyle(color: Colors.black54),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: screenWidth * 0.04,
                                        top: screenHeight * 0.01,
                                        bottom: screenHeight * 0.02),
                                    child: Text(
                                      "${obj.isNotEmpty ? obj[0].visaStatus : 'N/A'}",
                                      style: const TextStyle(
                                          color: secondarylightPurple,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                        right: screenWidth * 0.04,
                                        top: screenHeight * 0.02,
                                      ),
                                      child: const Text(
                                        "Nationality",
                                        style: TextStyle(color: Colors.black54),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(
                                          right: screenWidth * 0.05,
                                          top: screenHeight * 0.01,
                                          bottom: screenHeight * 0.02),
                                      child: Text(
                                        obj.isNotEmpty ? obj[0].nationality.toString() : 'N/A',
                                        style: const TextStyle(
                                            color: secondarylightPurple,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: screenWidth * 0.04,
                              top: screenHeight * 0.01),
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Country",
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              Text(
                                "${obj.isEmpty ? obj[0].country : 'United Arab Emirates'}",
                                style: const TextStyle(
                                    color: secondarylightPurple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: screenWidth * 0.04,
                              top: screenHeight * 0.03),
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "City",
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              Text(
                                "${obj.isNotEmpty ? obj[0].city : "Nil"}",
                                style: const TextStyle(
                                    color: secondarylightPurple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: screenWidth * 0.04,
                              top: screenHeight * 0.03),
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "File No",
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              Text(
                                "${obj.isNotEmpty ? obj[0].fileNo: ''}",
                                style: const TextStyle(
                                    color: secondarylightPurple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

}
