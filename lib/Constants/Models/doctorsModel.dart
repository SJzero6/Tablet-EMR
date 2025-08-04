class DoctorData {
  int id;
  String? doctorName;
  String? doctorDepartment;
  String doctorProfile;
  String? experiance;

  DoctorData(
      {required this.id,
      required this.doctorName,
      required this.doctorDepartment,
      required this.doctorProfile,
      this.experiance});

  factory DoctorData.fromJson(Map<String, dynamic> json) => DoctorData(
      id: json['Id'],
      doctorName: json['DoctorName'],
      doctorDepartment: json['DoctorDepartment'],
      doctorProfile: json['ProfilePhoto'],
      experiance: json['Experince']);

  Map<String, dynamic> toJson() => {
        'Id': id,
        'DoctorName': doctorName,
        'DoctorDepartment': doctorDepartment,
        'ProfilePhoto': doctorProfile,
        'Experince': experiance
      };
}
