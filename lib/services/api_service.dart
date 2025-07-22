import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/symptom_data.dart';
import '../models/prediction_result.dart';
import '../models/statistics_data.dart';

class ApiService {
  // Network configuration for different environments
  static const bool _useNgrokForTesting = true; // Set to false for production

  // PRODUCTION: Local network only (final deployment)
  static const String _productionIp = 'http://192.168.1.100:5000';

  // TESTING: NGrok tunnel for development testing only
  static const String _testingNgrokUrl =
      'https://your-ngrok-url.ngrok.io'; // Update this with your actual NGrok URL

  static String get _baseUrl =>
      _useNgrokForTesting ? _testingNgrokUrl : _productionIp;
  static const String _predictEndpoint = '/predict';

  static String get _fullUrl => '$_baseUrl$_predictEndpoint';

  // Submit symptom data and get prediction
  static Future<PredictionResult> submitSymptomData(SymptomData data) async {
    try {
      final response = await http
          .post(
            Uri.parse(_fullUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data.toJson()),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return PredictionResult.fromJson(jsonResponse);
      } else {
        throw ApiException('Server error: ${response.statusCode}');
      }
    } on http.ClientException {
      throw ApiException('Network error: Unable to connect to server');
    } on FormatException {
      throw ApiException('Invalid response format from server');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  // Validate network connectivity
  static Future<bool> validateNetworkConnectivity() async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/health'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Fetch statistics data with optional filters
  static Future<List<StatisticsData>> fetchStatisticsData({
    String? state,
    String? startDate,
    String? endDate,
    String? interval,
  }) async {
    final Map<String, String> queryParams = {};
    if (state != null && state.isNotEmpty) queryParams['state'] = state;
    if (startDate != null && startDate.isNotEmpty) {
      queryParams['start_date'] = startDate;
    }
    if (endDate != null && endDate.isNotEmpty) {
      queryParams['end_date'] = endDate;
    }
    if (interval != null && interval.isNotEmpty) {
      queryParams['interval'] = interval;
    }

    final uri = Uri.parse(
      '$_baseUrl/statistics',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http
          .get(uri, headers: {'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => StatisticsData.fromJson(json)).toList();
      } else {
        throw ApiException('Server error:  {response.statusCode}');
      }
    } on http.ClientException {
      throw ApiException('Network error: Unable to connect to server');
    } on FormatException {
      throw ApiException('Invalid response format from server');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  // Get current API configuration info
  static String getApiInfo() {
    return 'API URL: $_fullUrl\nMode: ${_useNgrokForTesting ? "Testing (NGrok)" : "Production (Local Network)"}';
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}
