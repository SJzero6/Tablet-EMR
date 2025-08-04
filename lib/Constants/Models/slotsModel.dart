class Timeslot {
  final String avlDate;
  final List<String> times;

  Timeslot({required this.avlDate, required this.times});

  factory Timeslot.fromJson(Map<String, dynamic> json) {
    return Timeslot(
      avlDate: json['AvlDate'],
      times: List<String>.from(json['time']),
    );
  }
}

class TimeslotResponse {
  final bool hasTimeslots;
  final List<Timeslot> timeslots;
  final String returnMessage;
  final String nextAvailableDate;
  final int returnCode;
  final double slotGap;

  TimeslotResponse({
    required this.hasTimeslots,
    required this.timeslots,
    required this.returnMessage,
    required this.nextAvailableDate,
    required this.returnCode,
    required this.slotGap,
  });

  factory TimeslotResponse.fromJson(Map<String, dynamic> json) {
    return TimeslotResponse(
      hasTimeslots: json['has_timeslots'],
      timeslots:
          (json['timeslots'] as List).map((i) => Timeslot.fromJson(i)).toList(),
      returnMessage: json['return_message'],
      nextAvailableDate: json['next_available_date'],
      returnCode: json['return_code'],
      slotGap: json['SlotGap'].toDouble(),
    );
  }
}
