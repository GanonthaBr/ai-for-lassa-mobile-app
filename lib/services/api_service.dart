import 'dart:convert';
import 'dart:io';
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
      'https://ai4lassa-api.onrender.com'; // Updated with actual NGrok URL

  // STATISTICS API: Separate URL for statistics data
  static const String _statisticsApiUrl = 'https://ai4lassa-api.onrender.com';

  static String get _baseUrl =>
      _useNgrokForTesting ? _testingNgrokUrl : _productionIp;
  static const String _predictEndpoint = '/predict';

  static String get _fullUrl => '$_baseUrl$_predictEndpoint';

  // Submit symptom data and get prediction
  static Future<PredictionResult> submitSymptomData(SymptomData data) async {
    try {
      print('Data: ${data.toJson()}');

      final response = await http
          .post(
            Uri.parse(_fullUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data.toJson()),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        final jsonResponse = jsonDecode(response.body);
        return PredictionResult.fromJson(jsonResponse);
      } else if (response.statusCode == 404) {
        throw ApiException('Service temporarily unavailable');
      } else if (response.statusCode >= 500) {
        throw ApiException('Server temporarily unavailable');
      } else {
        throw ApiException('Service temporarily unavailable');
      }
    } on http.ClientException {
      throw ApiException('Network connection error');
    } on FormatException {
      throw ApiException('Invalid response format');
    } catch (e) {
      print('Error: $e');
      throw ApiException('Unexpected error occurred');
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
    int? startYear,
    int? endYear,
    int? startMonth,
    int? endMonth,
  }) async {
    try {
      final uri = Uri.parse(
        '$_statisticsApiUrl/history?state=$state&start_year=$startYear&end_year=$endYear&start_month=$startMonth&end_month=$endMonth',
      );

      final response = await http.get(uri).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => StatisticsData.fromJson(json)).toList();
      } else {
        throw ApiException('Service temporarily unavailable');
      }
    } on SocketException {
      throw ApiException('Network connection error');
    } on FormatException {
      throw ApiException('Invalid response format');
    } catch (e) {
      throw ApiException('Unexpected error occurred');
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
