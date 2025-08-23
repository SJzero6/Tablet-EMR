import 'package:intl/intl.dart';

class AppoinmentData {
  String? doctorName;
  String? doctorDepartment;
  String doctorProfile;
  String appoinmentDate;
  String? appointmentTime;
  DateTime appointmentDateTime;
  int? appointmentId;
  int? doctorid;

  AppoinmentData({
    this.doctorName,
    this.doctorDepartment,
    required this.doctorProfile,
    this.appointmentTime,
    required this.appoinmentDate,
    required this.appointmentDateTime,
    this.appointmentId,
    this.doctorid,
  });

  factory AppoinmentData.fromJson(Map<String, dynamic> json) => AppoinmentData(
        doctorName: json['DoctorName'],
        doctorDepartment: json['DepartmentName'],
        doctorProfile: json['DocProfilePhoto'],
        appointmentTime: json['AppointmentTime'],
        appoinmentDate: json['AppointmentDate'],
        appointmentDateTime:
            DateFormat('dd/MM/yyyy').parseStrict(json['AppointmentDate']),
        appointmentId: json["appointment_id"],
        doctorid: json['doctor_id'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'DoctorName': doctorName,
        'DepartmentName': doctorDepartment,
        'DocProfilePhoto': doctorProfile,
        'AppointmentTime': appointmentTime,
        'AppointmentDate': appoinmentDate,
        "appointment_id": appointmentId,
        "doctor_id":doctorid,
      };

  // Method to copy the current instance with optional new values for some fields
}
