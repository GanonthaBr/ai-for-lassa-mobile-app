class StatisticsData {
  final int cases;
  final int deaths;
  final int recoveries;
  final int month;
  final int year;
  final String? state; // Optional, for display purposes

  StatisticsData({
    required this.cases,
    required this.deaths,
    required this.recoveries,
    required this.month,
    required this.year,
    this.state,
  });

  factory StatisticsData.fromJson(Map<String, dynamic> json) {
    return StatisticsData(
      cases: json['cases'],
      deaths: json['deaths'],
      recoveries: json['recoveries'],
      month: json['month'],
      year: json['year'],
    );
  }

  // Helper method to get month name
  String get monthName {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  // Helper method to get formatted date
  String get formattedDate => '$monthName $year';

  // Helper method to get mortality rate
  double get mortalityRate {
    if (cases == 0) return 0.0;
    return (deaths / cases * 100);
  }

  // Helper method to get recovery rate
  double get recoveryRate {
    if (cases == 0) return 0.0;
    return (recoveries / cases * 100);
  }
}
