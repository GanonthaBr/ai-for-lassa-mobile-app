class PredictionResult {
  final double prediction;
  final String risk;

  PredictionResult({required this.prediction, required this.risk});
  //on a scale of 1 to 100, 100 is the highest risk and 1 is the lowest risk

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    final double prediction = json['prediction'];

    // Map prediction percentage to risk level
    String risk;
    if (prediction >= 70) {
      risk = 'High';
    } else if (prediction >= 40) {
      risk = 'Medium';
    } else {
      risk = 'Low';
    }

    return PredictionResult(prediction: prediction, risk: risk);
  }
}
