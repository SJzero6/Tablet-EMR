class RecentTreatmentData {
  int id;
  String? doctorName;
  String? startTime;
  String? createdDate;
  String? endTime;

  RecentTreatmentData({
    required this.id,
    required this.doctorName,
    required this.startTime,
    required this.createdDate,
    required this.endTime,
  });

  factory RecentTreatmentData.fromJson(Map<String, dynamic> json) =>
      RecentTreatmentData(
        id: json['Id'],
        doctorName: json['DoctorName'],
        startTime: json['StartTime'],
        createdDate: json['CreatedDate'],
        endTime: json['EndTime'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'DoctorName': doctorName,
        'StartTime': startTime,
        'CreatedDate': createdDate,
        'EndTime': endTime,
      };
}
