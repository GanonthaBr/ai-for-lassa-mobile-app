class SymptomData {
  final int fever;
  final int bleeding;
  final int headache;
  final int vomiting;
  final double temperature;
  final double humidity;

  SymptomData({
    required this.fever,
    required this.bleeding,
    required this.headache,
    required this.vomiting,
    required this.temperature,
    required this.humidity,
  });

  Map<String, dynamic> toJson() {
    return {
      'fever': fever,
      'bleeding': bleeding,
      'headache': headache,
      'vomiting': vomiting,
      'temperature': temperature,
      'humidity': humidity,
    };
  }
}
