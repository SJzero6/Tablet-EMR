class ProfileData {
  String? name;
  String? number;
  String? email;
  String? gender;
  String? visaStatus;
  String? nationality;
  String? country;
  String? city;
  String? dob;
  String? area;
  String? profilePhoto;
  String? eid;
  String? fileNo;
  ProfileData(
      {required this.name,
      required this.number,
      required this.dob,
      required this.email,
      required this.gender,
      required this.visaStatus,
      required this.nationality,
      required this.country,
      required this.city,
      required this.area,
      required this.profilePhoto,
      required this.eid,
      required this.fileNo});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
        name: json['PatientName'] ?? '',
        number: json['MobileNumber'] ?? '',
        dob: json['DOB'] ?? '',
        email: json['Email'] ?? 'Nill',
        gender: json['Gender'] ?? '',
        visaStatus: json['VisaStatus'] ?? '',
        nationality: json['Nationality'] ?? '',
        country: json['Country'] ?? 'UNITED ARAB EMIRATES',
        city: json['City'] ?? 'Dubai',
        area: json['Area'] ?? 'Nill',
        profilePhoto: json['PatientPhoto'],
        eid: json['EmiratesId'] ?? '',
        fileNo: json['FileNumber'] ?? '');
  }
}
