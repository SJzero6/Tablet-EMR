class UpdateAppoinmentData {
  final String appointmentId;
  final String appoinmentDate;
  final String doctorId;
  final String patientId;
  // Add other necessary fields

  UpdateAppoinmentData({
    required this.appointmentId,
    required this.appoinmentDate,
    required this.doctorId,
    required this.patientId,
    // Initialize other fields
  });

  UpdateAppoinmentData copyWith({
    String? appointmentId,
    String? appoinmentDate,
    String? doctorId,
    String? patientId,
    // Other fields
  }) {
    return UpdateAppoinmentData(
      appointmentId: appointmentId ?? this.appointmentId,
      appoinmentDate: appoinmentDate ?? this.appoinmentDate,
      doctorId: doctorId ?? this.doctorId,
      patientId: patientId ?? this.patientId,
      // Copy other fields
    );
  }
}
