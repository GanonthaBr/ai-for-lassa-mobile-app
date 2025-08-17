import 'package:flutter/foundation.dart';
import '../models/statistics_data.dart';
import '../services/api_service.dart';

class DataBrowsingProvider extends ChangeNotifier {
  List<StatisticsData> _statisticsData = [];
  bool _isLoading = false;
  String? _error;
  String? _selectedState;
  int? _startYear;
  int? _endYear;
  int? _startMonth;
  int? _endMonth;

  // Getters
  List<StatisticsData> get statisticsData => _statisticsData;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedState => _selectedState;
  int? get startYear => _startYear;
  int? get endYear => _endYear;
  int? get startMonth => _startMonth;
  int? get endMonth => _endMonth;

  // Setters
  void setSelectedState(String? state) {
    _selectedState = state;
    notifyListeners();
  }

  void setStartYear(int? year) {
    _startYear = year;
    notifyListeners();
  }

  void setEndYear(int? year) {
    _endYear = year;
    notifyListeners();
  }

  void setStartMonth(int? month) {
    _startMonth = month;
    notifyListeners();
  }

  void setEndMonth(int? month) {
    _endMonth = month;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Clear all data
  void clearData() {
    _statisticsData = [];
    _error = null;
    notifyListeners();
  }

  // Fetch statistics data
  Future<void> fetchStatisticsData({
    required String state,
    required int startYear,
    required int endYear,
    required int startMonth,
    required int endMonth,
  }) async {
    // Validate inputs
    if (state.isEmpty) {
      _error = 'Please select a state';
      notifyListeners();
      return;
    }

    if (startYear > endYear) {
      _error = 'Start year cannot be greater than end year';
      notifyListeners();
      return;
    }

    if (startMonth < 1 || startMonth > 12 || endMonth < 1 || endMonth > 12) {
      _error = 'Month must be between 1 and 12';
      notifyListeners();
      return;
    }

    if (startMonth > endMonth) {
      _error = 'Start month cannot be greater than end month';
      notifyListeners();
      return;
    }

    // Set loading state
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Update provider state
      _selectedState = state;
      _startYear = startYear;
      _endYear = endYear;
      _startMonth = startMonth;
      _endMonth = endMonth;

      // Fetch data from API
      final results = await ApiService.fetchStatisticsData(
        state: state,
        startYear: startYear,
        endYear: endYear,
        startMonth: startMonth,
        endMonth: endMonth,
      );

      // Add state to each result for display
      _statisticsData = results
          .map(
            (stat) => StatisticsData(
              cases: stat.cases,
              deaths: stat.deaths,
              recoveries: stat.recoveries,
              month: stat.month,
              year: stat.year,
              state: state,
            ),
          )
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get available states (you can expand this list)
  List<String> get availableStates => [
    'Abia',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'FCT',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara',
  ];

  // Get available months
  List<String> get availableMonths => [
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

  // Get default year range (current year and previous year)
  Map<String, int> get defaultYearRange {
    final now = DateTime.now();
    return {'startYear': now.year - 1, 'endYear': now.year};
  }

  // Get default month range (full year)
  Map<String, int> get defaultMonthRange => {'startMonth': 1, 'endMonth': 12};

  // Check if search is valid
  bool get isSearchValid {
    return _selectedState != null &&
        _startYear != null &&
        _endYear != null &&
        _startMonth != null &&
        _endMonth != null;
  }

  // Get search parameters as a map
  Map<String, dynamic>? get searchParameters {
    if (!isSearchValid) return null;

    return {
      'state': _selectedState,
      'startYear': _startYear,
      'endYear': _endYear,
      'startMonth': _startMonth,
      'endMonth': _endMonth,
    };
  }
}
