import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:topline/Constants/Models/AccordianListModels/diagnosisModel.dart';
import 'package:topline/Constants/Models/AccordianListModels/priscriptionModel.dart';
import 'package:topline/Constants/Models/AccordianListModels/problemModel.dart';
import 'package:topline/Constants/Models/AccordianListModels/procdureModel.dart';
import 'package:topline/Constants/Models/AccordianListModels/triagesModel.dart';
import 'package:topline/Constants/apis.dart';
import 'package:topline/Constants/colors.dart';
import 'package:topline/Constants/routes.dart';
import 'package:topline/providers/authentication_provider.dart';
import 'package:topline/providers/cheifcomplaint_provider.dart';
import 'package:topline/providers/diagonsis_provider.dart';
import 'package:topline/providers/priscription_provider.dart';
import 'package:topline/providers/problem_provider.dart';
import 'package:topline/providers/procedures_provider.dart';
import 'package:topline/providers/triages_provider.dart';

class AccordionExample extends StatefulWidget {
  final int idData;
  AccordionExample({Key? key, required this.idData}) : super(key: key);
  @override
  _AccordionExampleState createState() => _AccordionExampleState();
}

class _AccordionExampleState extends State<AccordionExample> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchTreatmentData();
  }

  List<ProcedureData> procedureData = [];
  List<PatientPrescriptionData> prescriptionData = [];
  List<AppointmentTriagesData> triagesData = [];
  List<PatientDiagonosisData> diagnosisData = [];
  List<PatientProblemData> problemData = [];

  Future<void> _fetchTreatmentData() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.userId;
      final reportId = widget.idData;
      final procedureListService =
          Provider.of<ProcedureListService>(context, listen: false);
      final prescriptionListService =
          Provider.of<PrescriptionListService>(context, listen: false);
      final triagesListService =
          Provider.of<TriagesListService>(context, listen: false);
      final diagnosisService =
          Provider.of<DiagonsisService>(context, listen: false);
      final problemListService =
          Provider.of<ProblemListService>(context, listen: false);
      final chiefComplaint =
          Provider.of<ChiefComplaintsProvider>(context, listen: false);

      setState(() {
        loading = true;
      });

      final procedures = await procedureListService
          .getProcedureTest("$proceduresApi$userId&appId=$reportId");
      final prescriptions = await prescriptionListService
          .getPriscriptionTest("$proceduresApi$userId&appId=$reportId");
      final triages = await triagesListService
          .getTriagesData("$proceduresApi$userId&appId=$reportId");
      final diagnoses = await diagnosisService
          .getDiagonosisData("$proceduresApi$userId&appId=$reportId");
      final patientProblems = await problemListService
          .getProblemData("$proceduresApi$userId&appId=$reportId");
      chiefComplaint
          .fetchChiefComplaints("$proceduresApi$userId&appId=$reportId");

      setState(() {
        procedureData = procedures;
        prescriptionData = prescriptions;
        triagesData = triages;
        diagnosisData = diagnoses;
        problemData = patientProblems;
        loading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.patientHistory);
                },
                child: Center(
                  child: Icon(
                    Icons.chevron_left_rounded,
                    color: white,
                    size: 0.06.sh,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              margin: const EdgeInsets.only(top: 1),
              child: Text(
                "Treatment Report",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 0.02.sh,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding:const EdgeInsets.only(right: 5),
        physics:const BouncingScrollPhysics(),
        
        child: Column(
          children: [
            Accordion(
              headerBorderColor: Colors.white,
              headerBorderColorOpened: Colors.transparent,
              headerBackgroundColorOpened: secondaryPurple,
              contentBackgroundColor: Colors.white,
              contentBorderColor: secondaryPurple,
              contentBorderWidth: 3,
              contentHorizontalPadding: 20,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  headerBackgroundColor: secondaryPurple,
                  isOpen: false,
                  header: const Text(
                    'Patient Procedures',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(2.0),
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
                        : Table(
                            border: TableBorder.all(color: Colors.black),
                            columnWidths: const {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                            },
                            children: _buildProcedureTableRows(),
                          ),
                  ),
                ),
              ],
            ),
            Accordion(
              headerBorderColor: Colors.white,
              headerBorderColorOpened: Colors.transparent,
              headerBackgroundColorOpened: secondaryPurple,
              contentBackgroundColor: Colors.white,
              contentBorderColor: secondaryPurple,
              contentBorderWidth: 3,
              contentHorizontalPadding: 10,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  headerBackgroundColor: secondaryPurple,
                  isOpen: false,
                  header: const Text(
                    'Patient Priscription',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(2.0),
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
                        : Table(
                            border: TableBorder.all(color: Colors.black),
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                            },
                            children: _buildPriscriptionTableRows(),
                          ),
                  ),
                ),
              ],
            ),
            Accordion(
              headerBorderColor: Colors.white,
              headerBorderColorOpened: Colors.transparent,
              headerBackgroundColorOpened: secondaryPurple,
              contentBackgroundColor: Colors.white,
              contentBorderColor: secondaryPurple,
              contentBorderWidth: 3,
              contentHorizontalPadding: 20,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  headerBackgroundColor: secondaryPurple,
                  isOpen: false,
                  header: const Text(
                    'Patient Appointment Triages',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(2.0),
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
                        : Table(
                            border: TableBorder.all(color: Colors.black),
                            columnWidths: const {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                            },
                            children: _buildTrigesTableRows(),
                          ),
                  ),
                ),
              ],
            ),
            Accordion(
              headerBorderColor: Colors.white,
              headerBorderColorOpened: Colors.transparent,
              headerBackgroundColorOpened: secondaryPurple,
              contentBackgroundColor: Colors.white,
              contentBorderColor: secondaryPurple,
              contentBorderWidth: 3,
              contentHorizontalPadding: 20,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  headerBackgroundColor: secondaryPurple,
                  isOpen: false,
                  header: const Text(
                    'Patient Diagonosis',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(2.0),
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
                        : Table(
                            border: TableBorder.all(color: Colors.black),
                            columnWidths: const {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                            },
                            children: _buildDiagnosisTableRows(),
                          ),
                  ),
                ),
              ],
            ),
            Accordion(
              headerBorderColor: Colors.white,
              headerBorderColorOpened: Colors.transparent,
              headerBackgroundColorOpened: secondaryPurple,
              contentBackgroundColor: Colors.white,
              contentBorderColor: secondaryPurple,
              contentBorderWidth: 3,
              contentHorizontalPadding: 20,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  headerBackgroundColor: secondaryPurple,
                  isOpen: false,
                  header: const Text(
                    'Patient Problems',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(2.0),
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
                        : Table(
                            border: TableBorder.all(color: Colors.black),
                            columnWidths: const {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                            },
                            children: _buildProblemTableRows(),
                          ),
                  ),
                ),
              ],
            ),
            Accordion(
              headerBorderColor: Colors.white,
              headerBorderColorOpened: Colors.transparent,
              headerBackgroundColorOpened: secondaryPurple,
              contentBackgroundColor: Colors.white,
              contentBorderColor: secondaryPurple,
              contentBorderWidth: 3,
              contentHorizontalPadding: 20,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  headerBackgroundColor: secondaryPurple,
                  isOpen: false,
                  header: const Text(
                    'Cheif Complaints',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(2.0),
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
                        : Table(
                            border: TableBorder.all(color: Colors.black),
                            columnWidths: const {
                              0: FlexColumnWidth(2),
                            },
                            children: _buildComplaintTableRows(),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<TableRow> _buildProcedureTableRows() {
    List<TableRow> rows = [];

    // Adding header row
    rows.add(
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[300]),
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Procedure',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Discount\nAmount',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Gross\nAmount',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        ],
      ),
    );

    // Adding data rows
    for (var procedure in procedureData) {
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(procedure.procedureName ?? 'N/A'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(procedure.discountAmount?.toString() ?? '0'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(procedure.grossAmount?.toString() ?? '0'),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  List<TableRow> _buildPriscriptionTableRows() {
    List<TableRow> rows = [];

    // Adding header row
    rows.add(
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[300]),
        children: const [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Priscription',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Frequency',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Route',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Remark',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );

    // Adding data rows
    for (var priscription in prescriptionData) {
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(priscription.priscriptionName ?? 'N/A'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(priscription.frequency?.toString() ?? 'N/A'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(priscription.route?.toString() ?? 'N/A'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(priscription.remark?.toString() ?? 'N/A'),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  List<TableRow> _buildTrigesTableRows() {
    List<TableRow> rows = [];

    // Adding header row
    rows.add(
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[300]),
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Temperature',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'BP',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Weight',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'BMI',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );

    // Adding data rows
    for (var trigas in triagesData) {
      double number = double.parse(trigas.bmi.isEmpty ? "0.00" : trigas.bmi);
      String bmi = number.toStringAsFixed(2);
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(trigas.temperature ?? '0.0'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(trigas.bP ?? '0.0'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(trigas.weight ?? '0.0'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(bmi.toString()),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  List<TableRow> _buildDiagnosisTableRows() {
    List<TableRow> rows = [];

    // Adding header row
    rows.add(
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[300]),
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Diagonosis Name',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'ICPCODE',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Status',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        ],
      ),
    );

    // Adding data rows
    for (var daigonsis in diagnosisData) {
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(daigonsis.name ?? 'N/A'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(daigonsis.icdCode?.toString() ?? '0'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(daigonsis.status?.toString() ?? '0'),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  List<TableRow> _buildProblemTableRows() {
    List<TableRow> rows = [];

    // Adding header row
    rows.add(
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[300]),
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Diagonosis Name',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'ICPCODE',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Status',
              style: TextStyle(
                  color: secondaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        ],
      ),
    );

    // Adding data rows
    for (var problem in problemData) {
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(problem.name ?? 'N/A'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(problem.icdCode?.toString() ?? '0'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(problem.status?.toString() ?? '0'),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  List<TableRow> _buildComplaintTableRows() {
    List<TableRow> rows = [];

    // Adding header row
    rows.add(
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[300]),
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Chief Complaints',
              style: TextStyle(
                  color: secondaryPurple, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    // Adding data rows

    rows.add(
      TableRow(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ChiefComplaintsProvider>(
                  builder: (context, chiefComplaintsProvider, child) {
                return Text(
                  chiefComplaintsProvider.chiefComplaints.isNotEmpty
                      ? chiefComplaintsProvider.chiefComplaints
                      : 'No Chief Complaints',
                );
              }))
        ],
      ),
    );

    return rows;
  }
}
