class PatientDiagonosisData {
  String? name;
  String? icdCode;
  String? status;

  PatientDiagonosisData({
    required this.name,
    required this.icdCode,
    required this.status,
  });

  factory PatientDiagonosisData.fromJson(Map<String, dynamic> json) {
    return PatientDiagonosisData(
      name: json['name'] ?? "",
      icdCode: json['ICDCode'] ?? "",
      status: json['Status'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'ICDCode': icdCode,
        'Status': status,
      };
}
