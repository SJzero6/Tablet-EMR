class AppointmentTriagesData {
  String? temperature;
  String? bP;
  String bmi;
  String? weight;

  AppointmentTriagesData({
    required this.temperature,
    required this.bP,
    required this.bmi,
    required this.weight,
  });

  factory AppointmentTriagesData.fromJson(Map<String, dynamic> json) {
    return AppointmentTriagesData(
      temperature: json['Temperature'] ?? "",
      bP: json['BP'] ?? "",
      bmi: json['BMI'] ?? "",
      weight: json['Weight'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'Temperature': temperature,
        'BP': bP,
        'BMI': bmi,
        'Weight': weight,
      };
}
