class BillingData {
  String? invoiceDate;
  String? invoiceNumber;
  double? paidAmount;
  double? balance;

  BillingData(
      {required this.invoiceDate,
      required this.invoiceNumber,
      required this.paidAmount,
      required this.balance});

  factory BillingData.fromJson(Map<String, dynamic> json) => BillingData(
      invoiceDate: json['invoiceDate'],
      invoiceNumber: json['invoiceNumber'],
      paidAmount: json['paidAmount'],
      balance: json['Balance']);

  Map<String, dynamic> toJson() => {
        'invoiceDate': invoiceDate,
        'invoiceNumber': invoiceNumber,
        'paidAmount': paidAmount,
        'Balance': balance,
      };
}
