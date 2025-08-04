class PatientPrescriptionData {
  String? priscriptionName;
  String? frequency;
  String? route;
  String? remark;

  PatientPrescriptionData({
    required this.priscriptionName,
    required this.frequency,
    required this.route,
    required this.remark,
  });

  factory PatientPrescriptionData.fromJson(Map<String, dynamic> json) {
    return PatientPrescriptionData(
      priscriptionName: json['PrescriptionName'] ?? "",
      frequency: json['Frequency'] ?? "",
      route: json['Routes'] ?? "",
      remark: json['Remarks'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'PrescriptionName': priscriptionName,
        'Frequency': frequency,
        'Routes': route,
        'Remarks': remark,
      };
}
