class StatisticsData {
  final String state;
  final String month;
  final int cases;
  final int deaths;
  final int recoveries;

  StatisticsData({
    required this.state,
    required this.month,
    required this.cases,
    required this.deaths,
    required this.recoveries,
  });

  factory StatisticsData.fromJson(Map<String, dynamic> json) {
    return StatisticsData(
      state: json['state'],
      month: json['month'],
      cases: json['cases'],
      deaths: json['deaths'],
      recoveries: json['recoveries'],
    );
  }
}
