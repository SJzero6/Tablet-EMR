class Registration {
  final String patientName;
  final String emiratesId;
  final String mobileNumber;
  final String email;
  String username;
  String password;
  bool isKeyActive;
  String regToken;

  Registration({
    required this.patientName,
    required this.emiratesId,
    required this.mobileNumber,
    required this.email,
    required this.username,
    required this.password,
    required this.isKeyActive,
    required this.regToken,
  });
  Map<String, dynamic> toJson() {
    return {
      'PatientName': patientName,
      'EmiratesId': emiratesId,
      'MobileNumber': mobileNumber,
      'Email': email,
      'Username': username,
      'Password': password,
      'IsKeyActive': isKeyActive,
      'RegToken': regToken,
    };
  }
}
