class SymptomData {
  final int fever;
  final int bleeding;
  final int headache;
  final int vomiting;
  final double temperature;

  SymptomData({
    required this.fever,
    required this.bleeding,
    required this.headache,
    required this.vomiting,
    required this.temperature,
  });

  Map<String, dynamic> toJson() {
    return {
      'fever': fever,
      'bleeding': bleeding,
      'headache': headache,
      'vomiting': vomiting,
      'temperature': temperature,
    };
  }
}
