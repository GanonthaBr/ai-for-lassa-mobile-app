import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/statistics_data.dart';
import '../services/data_browsing_provider.dart';
import '../utils/constants.dart';
import 'statistics_results_screen.dart';

class DataBrowserScreen extends StatefulWidget {
  const DataBrowserScreen({Key? key}) : super(key: key);

  @override
  State<DataBrowserScreen> createState() => _DataBrowserScreenState();
}

class _DataBrowserScreenState extends State<DataBrowserScreen> {
  // Controllers for text fields
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _startMonthController = TextEditingController();
  final TextEditingController _endMonthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with default values
    final provider = Provider.of<DataBrowsingProvider>(context, listen: false);
    final defaultYearRange = provider.defaultYearRange;
    final defaultMonthRange = provider.defaultMonthRange;

    _startYearController.text = defaultYearRange['startYear'].toString();
    _endYearController.text = defaultYearRange['endYear'].toString();
    _startMonthController.text = defaultMonthRange['startMonth'].toString();
    _endMonthController.text = defaultMonthRange['endMonth'].toString();
  }

  @override
  void dispose() {
    _startYearController.dispose();
    _endYearController.dispose();
    _startMonthController.dispose();
    _endMonthController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final provider = Provider.of<DataBrowsingProvider>(context, listen: false);

    // Parse and validate year inputs
    final startYear = int.tryParse(_startYearController.text);
    final endYear = int.tryParse(_endYearController.text);

    if (startYear == null || endYear == null) {
      // We'll let the provider handle validation
      return;
    }

    // Parse and validate month inputs
    final startMonth = int.tryParse(_startMonthController.text);
    final endMonth = int.tryParse(_endMonthController.text);

    if (startMonth == null || endMonth == null) {
      // We'll let the provider handle validation
      return;
    }

    // Fetch data using provider
    await provider.fetchStatisticsData(
      state: provider.selectedState ?? '',
      startYear: startYear,
      endYear: endYear,
      startMonth: startMonth,
      endMonth: endMonth,
    );

    // If successful and no error, navigate to results
    if (provider.error == null && provider.statisticsData.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => StatisticsResultsScreen(
            results: provider.statisticsData,
            selectedState: provider.selectedState!,
            startYear: startYear,
            endYear: endYear,
            startMonth: startMonth,
            endMonth: endMonth,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataBrowsingProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Browse Statistics',
              style: AppConstants.getInterFont(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppConstants.primaryColor,
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: EdgeInsets.all(AppConstants.getResponsivePadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // State Selection
                Text(
                  'Select State',
                  style: AppConstants.getInterFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: AppConstants.getResponsiveSmallPadding(context),
                ),
                DropdownButtonFormField<String>(
                  value: provider.selectedState,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.getResponsiveButtonRadius(context),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppConstants.getResponsivePadding(context),
                      vertical: AppConstants.getResponsiveSmallPadding(context),
                    ),
                  ),
                  hint: Text(
                    'Choose a state',
                    style: AppConstants.getInterFont(),
                  ),
                  items: provider.availableStates
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(s, style: AppConstants.getInterFont()),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => provider.setSelectedState(val),
                ),
                SizedBox(
                  height: AppConstants.getResponsiveLargePadding(context),
                ),

                // Year Range
                Text(
                  'Year Range',
                  style: AppConstants.getInterFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: AppConstants.getResponsiveSmallPadding(context),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _startYearController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.getResponsiveButtonRadius(context),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.getResponsivePadding(
                              context,
                            ),
                            vertical: AppConstants.getResponsiveSmallPadding(
                              context,
                            ),
                          ),
                          labelText: 'Start Year',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppConstants.getResponsiveSmallPadding(context),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _endYearController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.getResponsiveButtonRadius(context),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.getResponsivePadding(
                              context,
                            ),
                            vertical: AppConstants.getResponsiveSmallPadding(
                              context,
                            ),
                          ),
                          labelText: 'End Year',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppConstants.getResponsiveLargePadding(context),
                ),

                // Month Range
                Text(
                  'Month Range',
                  style: AppConstants.getInterFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: AppConstants.getResponsiveSmallPadding(context),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _startMonthController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.getResponsiveButtonRadius(context),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.getResponsivePadding(
                              context,
                            ),
                            vertical: AppConstants.getResponsiveSmallPadding(
                              context,
                            ),
                          ),
                          labelText: 'Start Month (1-12)',
                          helperText: 'Enter 1-12',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppConstants.getResponsiveSmallPadding(context),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _endMonthController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.getResponsiveButtonRadius(context),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.getResponsivePadding(
                              context,
                            ),
                            vertical: AppConstants.getResponsiveSmallPadding(
                              context,
                            ),
                          ),
                          labelText: 'End Month (1-12)',
                          helperText: 'Enter 1-12',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppConstants.getResponsiveLargePadding(context),
                ),

                // Search Button
                SizedBox(
                  width: double.infinity,
                  height: AppConstants.getResponsiveButtonHeight(context),
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _search,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.getResponsiveButtonRadius(context),
                        ),
                      ),
                    ),
                    child: provider.isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            'Search Statistics',
                            style: AppConstants.getInterFont(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: AppConstants.getResponsiveLargePadding(context),
                ),

                // Error Display
                if (provider.error != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(
                      AppConstants.getResponsivePadding(context),
                    ),
                    decoration: BoxDecoration(
                      color: AppConstants.errorColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        AppConstants.getResponsiveButtonRadius(context),
                      ),
                      border: Border.all(
                        color: AppConstants.errorColor.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      provider.error!,
                      style: AppConstants.getInterFont(
                        color: AppConstants.errorColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                // Spacer to push content to top
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        );
      },
    );
  }
}
