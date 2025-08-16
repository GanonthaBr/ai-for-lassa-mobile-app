import 'package:flutter/material.dart';
import '../models/statistics_data.dart';
import '../utils/constants.dart';

class StatisticsResultsScreen extends StatelessWidget {
  final List<StatisticsData> results;
  final String selectedState;
  final int startYear;
  final int endYear;
  final int startMonth;
  final int endMonth;

  const StatisticsResultsScreen({
    Key? key,
    required this.results,
    required this.selectedState,
    required this.startYear,
    required this.endYear,
    required this.startMonth,
    required this.endMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Statistics Results',
          style: AppConstants.getInterFont(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppConstants.primaryColor,
                AppConstants.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.share_rounded),
              onPressed: () {
                _showShareBottomSheet(context);
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.primaryColor.withOpacity(0.05),
              Colors.grey[50]!,
              Colors.white,
            ],
            stops: const [0.0, 0.3, 1.0],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Top spacing for app bar
            const SliverToBoxAdapter(child: SizedBox(height: 100)),

            // Enhanced header with search criteria
            SliverToBoxAdapter(child: _buildEnhancedHeader(context)),

            // Summary statistics card
            if (results.isNotEmpty)
              SliverToBoxAdapter(child: _buildSummaryCard(context)),

            // Results list
            results.isEmpty
                ? SliverFillRemaining(child: _buildEnhancedEmptyState(context))
                : SliverPadding(
                    padding: EdgeInsets.all(
                      AppConstants.getResponsivePadding(context),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 300 + (index * 100)),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 50 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        AppConstants.getResponsiveSmallPadding(
                                          context,
                                        ),
                                  ),
                                  child: _buildEnhancedStatisticsCard(
                                    context,
                                    results[index],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }, childCount: results.length),
                    ),
                  ),

            // Bottom padding
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppConstants.getResponsivePadding(context)),
      padding: EdgeInsets.all(AppConstants.getResponsivePadding(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.primaryColor,
                      AppConstants.primaryColor.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Results',
                      style: AppConstants.getInterFont(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${results.length} records found',
                      style: AppConstants.getInterFont(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Enhanced criteria items
          Row(
            children: [
              Expanded(
                child: _buildEnhancedCriteriaItem(
                  context,
                  'Location',
                  selectedState,
                  Icons.location_on_outlined,
                  AppConstants.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildEnhancedCriteriaItem(
                  context,
                  'Period',
                  '${_getMonthName(startMonth)} $startYear - ${_getMonthName(endMonth)} $endYear',
                  Icons.calendar_today_outlined,
                  AppConstants.successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedCriteriaItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppConstants.getInterFont(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppConstants.getInterFont(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final totalCases = results.fold<int>(0, (sum, stat) => sum + stat.cases);
    final totalDeaths = results.fold<int>(0, (sum, stat) => sum + stat.deaths);
    final totalRecoveries = results.fold<int>(
      0,
      (sum, stat) => sum + stat.recoveries,
    );
    final avgMortalityRate =
        results.fold<double>(0, (sum, stat) => sum + stat.mortalityRate) /
        results.length;
    final avgRecoveryRate =
        results.fold<double>(0, (sum, stat) => sum + stat.recoveryRate) /
        results.length;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.getResponsivePadding(context),
        vertical: 8,
      ),
      padding: EdgeInsets.all(AppConstants.getResponsivePadding(context)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppConstants.primaryColor.withOpacity(0.1),
            AppConstants.successColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppConstants.primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.summarize_rounded,
                color: AppConstants.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Summary Statistics',
                style: AppConstants.getInterFont(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Total stats
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Total Cases',
                  _formatNumber(totalCases),
                  AppConstants.primaryColor,
                  Icons.people_rounded,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Total Deaths',
                  _formatNumber(totalDeaths),
                  AppConstants.errorColor,
                  Icons.favorite_border_rounded,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Total Recoveries',
                  _formatNumber(totalRecoveries),
                  AppConstants.successColor,
                  Icons.healing_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Average rates
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Avg Mortality',
                  '${avgMortalityRate.toStringAsFixed(1)}%',
                  AppConstants.errorColor,
                  Icons.trending_down_rounded,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Avg Recovery',
                  '${avgRecoveryRate.toStringAsFixed(1)}%',
                  AppConstants.successColor,
                  Icons.trending_up_rounded,
                ),
              ),
              const Expanded(child: SizedBox()), // Empty space for alignment
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppConstants.getInterFont(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: AppConstants.getInterFont(
              fontSize: 10,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[100]!, Colors.grey[50]!],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.analytics_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: AppConstants.getResponsivePadding(context)),
          Text(
            'No Data Available',
            style: AppConstants.getInterFont(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: AppConstants.getResponsiveSmallPadding(context)),
          Text(
            'Try adjusting your search criteria\nto find relevant statistics',
            style: AppConstants.getInterFont(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.search_rounded),
            label: const Text('Modify Search'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedStatisticsCard(
    BuildContext context,
    StatisticsData stat,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showDetailBottomSheet(context, stat),
          child: Padding(
            padding: EdgeInsets.all(AppConstants.getResponsivePadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stat.formattedDate,
                            style: AppConstants.getInterFont(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (stat.state != null)
                            Text(
                              stat.state!,
                              style: AppConstants.getInterFont(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.primaryColor.withOpacity(0.2),
                            AppConstants.primaryColor.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'View Details',
                        style: AppConstants.getInterFont(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Enhanced main statistics with progress indicators
                Row(
                  children: [
                    Expanded(
                      child: _buildEnhancedStatItem(
                        context,
                        'Cases',
                        stat.cases.toString(),
                        AppConstants.primaryColor,
                        Icons.people_rounded,
                        stat.cases /
                            (stat.cases + stat.deaths + stat.recoveries),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildEnhancedStatItem(
                        context,
                        'Deaths',
                        stat.deaths.toString(),
                        AppConstants.errorColor,
                        Icons.favorite_border_rounded,
                        stat.deaths /
                            (stat.cases + stat.deaths + stat.recoveries),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildEnhancedStatItem(
                        context,
                        'Recoveries',
                        stat.recoveries.toString(),
                        AppConstants.successColor,
                        Icons.healing_rounded,
                        stat.recoveries /
                            (stat.cases + stat.deaths + stat.recoveries),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Enhanced rates with visual indicators
                Row(
                  children: [
                    Expanded(
                      child: _buildEnhancedRateItem(
                        context,
                        'Mortality Rate',
                        '${stat.mortalityRate.toStringAsFixed(1)}%',
                        AppConstants.errorColor,
                        stat.mortalityRate / 100,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildEnhancedRateItem(
                        context,
                        'Recovery Rate',
                        '${stat.recoveryRate.toStringAsFixed(1)}%',
                        AppConstants.successColor,
                        stat.recoveryRate / 100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedStatItem(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
    double progress,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            _formatNumber(int.parse(value)),
            style: AppConstants.getInterFont(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppConstants.getInterFont(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Progress indicator
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedRateItem(
    BuildContext context,
    String label,
    String value,
    Color color,
    double progress,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppConstants.getInterFont(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: AppConstants.getInterFont(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Share Statistics',
              style: AppConstants.getInterFont(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(Icons.file_copy_rounded, 'Export CSV', () {}),
                _buildShareOption(
                  Icons.picture_as_pdf_rounded,
                  'Export PDF',
                  () {},
                ),
                _buildShareOption(Icons.share_rounded, 'Share Link', () {}),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppConstants.primaryColor, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppConstants.getInterFont(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailBottomSheet(BuildContext context, StatisticsData stat) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Detailed Statistics',
                      style: AppConstants.getInterFont(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      stat.formattedDate,
                      style: AppConstants.getInterFont(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Add detailed statistics view here
                      Text(
                        'No details to show',
                        style: AppConstants.getInterFont(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
