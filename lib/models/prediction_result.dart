class PredictionResult {
  final int prediction;
  final String risk;

  PredictionResult({required this.prediction, required this.risk});

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(prediction: json['prediction'], risk: json['risk']);
  }
}
