class PatientProblemData {
  String? name;
  String? icdCode;
  String? status;

  PatientProblemData({
    required this.name,
    required this.icdCode,
    required this.status,
  });

  factory PatientProblemData.fromJson(Map<String, dynamic> json) {
    return PatientProblemData(
      name: json['name'] ?? "",
      icdCode: json['ICDCode'] ?? "",
      status: json['status'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'ICDCode': icdCode,
        'status': status,
      };
}
