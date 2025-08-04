class ProcedureData {
  String? procedureName;
  double? discountAmount;
  double? grossAmount;

  ProcedureData({
    required this.procedureName,
    required this.discountAmount,
    required this.grossAmount,
  });

  factory ProcedureData.fromJson(Map<String, dynamic> json) {
    return ProcedureData(
      procedureName: json['ProcedureName'] ?? "",
      discountAmount: json['discountAmount'] ?? 0.0,
      grossAmount: json['grossAmount'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'ProcedureName': procedureName,
        'discountAmount': discountAmount,
        'grossAmount': grossAmount,
      };
}
