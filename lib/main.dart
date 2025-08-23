import 'package:flutter/material.dart';
import 'package:topline/Constants/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:topline/providers/appoinments_provider.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/billing_provider.dart';
import 'package:topline/providers/booking_provider.dart';
import 'package:topline/providers/cheifcomplaint_provider.dart';
import 'package:topline/providers/credential_provider.dart';
import 'package:topline/providers/diagonsis_provider.dart';
import 'package:topline/providers/doctor_provider.dart';
import 'package:topline/providers/forgotPasswordProvider.dart';
import 'package:topline/providers/labReport_provider.dart';
import 'package:topline/providers/patientHistory_provider.dart';
import 'package:topline/providers/patientProfile_provider.dart';
import 'package:topline/providers/priscription_provider.dart';
import 'package:topline/providers/problem_provider.dart';
import 'package:topline/providers/procedures_provider.dart';
import 'package:topline/providers/resetPasswordProvider.dart';
import 'package:topline/providers/slots_provider.dart';
import 'package:topline/providers/triages_provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the screen orientation to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => CredentialProvider()),
              ChangeNotifierProvider(create: (_) => DoctorProvider()),
              ChangeNotifierProvider(create: (_) => AppointmentProvider()),
              ChangeNotifierProvider(create: (_) => LabReportService()),
              ChangeNotifierProvider(create: (_) => BillingDataService()),
              ChangeNotifierProvider(create: (_) => PatientHistoryService()),
              ChangeNotifierProvider(create: (_) => ProcedureListService()),
              ChangeNotifierProvider(create: (_) => PrescriptionListService()),
              ChangeNotifierProvider(create: (_) => DiagonsisService()),
              ChangeNotifierProvider(create: (_) => ProblemListService()),
              ChangeNotifierProvider(create: (_) => ChiefComplaintsProvider()),
              ChangeNotifierProvider(create: (_) => SlotBookingProvider()),
              ChangeNotifierProvider(create: (_) => TimeslotProvider()),
              ChangeNotifierProvider(create: (_) => ProfileService()),
              ChangeNotifierProvider(create: (_) => TriagesListService()),
              ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
              ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
            ],
            child: MaterialApp(
              initialRoute: AppRoutes.splash,
              routes: AppRoutes.routes,
              debugShowCheckedModeBanner: false,
            ),
          );
        });
  }
}
