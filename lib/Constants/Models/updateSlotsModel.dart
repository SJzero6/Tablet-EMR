class UpdateTimeSlot {
  final List<String> time;

  UpdateTimeSlot({required this.time});

  factory UpdateTimeSlot.fromJson(Map<String, dynamic> json) {
    print('Creating TimeSlot from JSON: $json');
    // Extract the list of times from the first item in the 'timeslots' list
    final timeslots = json['timeslots'] as List<dynamic>;
    if (timeslots.isNotEmpty) {
      final times = timeslots[0]['time'] as List<dynamic>;
      return UpdateTimeSlot(
        time: List<String>.from(times),
      );
    }
    return UpdateTimeSlot(time: []);
  }
}
