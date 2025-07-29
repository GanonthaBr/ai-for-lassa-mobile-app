import 'package:ai4lassa/models/symptom_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/symptom_analysis_provider.dart';
import '../utils/constants.dart';
import '../widgets/symptom_form.dart';
import '../widgets/result_display.dart';
import 'data_browser_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SymptomAnalysisProvider(),
      child: Consumer<SymptomAnalysisProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: _buildAppBar(),
            drawer: _buildDrawer(),
            body: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Column(
                      children: [
                        // Progress Indicator
                        _buildProgressIndicator(provider),

                        // Scrollable Content
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(
                              AppConstants.defaultPadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Header Section with Stats
                                _buildEnhancedHeaderSection(),

                                SizedBox(
                                  height:
                                      AppConstants.getResponsiveLargePadding(
                                        context,
                                      ),
                                ),

                                // Quick Stats
                                _buildQuickStats(),

                                SizedBox(
                                  height:
                                      AppConstants.getResponsiveLargePadding(
                                        context,
                                      ),
                                ),

                                // Steps Indicator
                                _buildStepsIndicator(provider),

                                SizedBox(
                                  height:
                                      AppConstants.getResponsiveLargePadding(
                                        context,
                                      ),
                                ),

                                // Symptom Form
                                _buildAnimatedSection(
                                  child: SymptomForm(
                                    initialFever: provider.fever,
                                    initialBleeding: provider.bleeding,
                                    initialHeadache: provider.headache,
                                    initialVomiting: provider.vomiting,
                                    initialTemperature: provider.temperature,
                                    onFeverChanged: provider.setFever,
                                    onBleedingChanged: provider.setBleeding,
                                    onHeadacheChanged: provider.setHeadache,
                                    onVomitingChanged: provider.setVomiting,
                                    onTemperatureChanged:
                                        provider.setTemperature,
                                  ),
                                  delay: 200,
                                ),

                                SizedBox(
                                  height:
                                      AppConstants.getResponsiveLargePadding(
                                        context,
                                      ),
                                ),

                                // Submit Button
                                _buildEnhancedSubmitButton(context, provider),

                                SizedBox(
                                  height:
                                      AppConstants.getResponsiveLargePadding(
                                        context,
                                      ),
                                ),

                                // // Button to show mock result for testing
                                // Padding(
                                //   padding: const EdgeInsets.only(bottom: 12.0),
                                //   child: ElevatedButton.icon(
                                //     onPressed: provider.setMockResult,
                                //     icon: const Icon(Icons.bug_report),
                                //     label: const Text('Show Sample Result'),
                                //     style: ElevatedButton.styleFrom(
                                //       backgroundColor: Colors.deepPurple,
                                //       foregroundColor: Colors.white,
                                //     ),
                                //   ),
                                // ),

                                // Result Display
                                _buildAnimatedSection(
                                  child: ResultDisplay(
                                    result: provider.result,
                                    isLoading: provider.isLoading,
                                    errorMessage: provider.errorMessage,
                                  ),
                                  delay: 600,
                                ),

                                SizedBox(
                                  height:
                                      AppConstants.getResponsiveLargePadding(
                                        context,
                                      ),
                                ),

                                // Help Section
                                _buildHelpSection(),

                                SizedBox(
                                  height:
                                      AppConstants.getResponsiveLargePadding(
                                        context,
                                      ) *
                                      2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: _buildFloatingActionButton(),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'AI4Lassa',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      backgroundColor: AppConstants.primaryColor,
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: Colors.white),
          onPressed: _showHelpDialog,
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            // Navigate to settings
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppConstants.primaryColor,
                  AppConstants.primaryColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.medical_services,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'AI4Lassa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Lassa Fever Detection',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            Icons.home,
            'Home',
            () => Navigator.pop(context),
            isSelected: true,
          ),
          _buildDrawerItem(Icons.bar_chart, 'Data Browser', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DataBrowserScreen(),
              ),
            );
          }),
          _buildDrawerItem(Icons.history, 'Assessment History', () {
            Navigator.pop(context);
            // TODO: Navigate to history screen
          }),
          const Divider(),
          _buildDrawerItem(Icons.info_outline, 'About', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            );
          }),
          _buildDrawerItem(Icons.contact_mail, 'Contact', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactScreen()),
            );
          }),
          _buildDrawerItem(Icons.settings, 'Settings', () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/settings');
          }),
          const Divider(),
          _buildDrawerItem(
            Icons.emergency,
            'Emergency',
            () {
              Navigator.pop(context);
              _showEmergencyDialog();
            },
            textColor: AppConstants.errorColor,
            iconColor: AppConstants.errorColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isSelected = false,
    Color? textColor,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? AppConstants.primaryColor.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color:
              iconColor ??
              (isSelected ? AppConstants.primaryColor : Colors.grey[600]),
        ),
        title: Text(
          title,
          style: AppConstants.bodyStyle.copyWith(
            color:
                textColor ??
                (isSelected ? AppConstants.primaryColor : Colors.black87),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildProgressIndicator(SymptomAnalysisProvider provider) {
    if (!provider.isLoading) return const SizedBox.shrink();

    return Container(
      height: 3,
      child: LinearProgressIndicator(
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
      ),
    );
  }

  Widget _buildEnhancedHeaderSection() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            padding: const EdgeInsets.all(AppConstants.largePadding),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppConstants.primaryColor,
                  AppConstants.primaryColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.primaryColor.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.medical_services,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                const Text(
                  'Lassa Fever Detection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.smallPadding),
                const Text(
                  'AI-powered screening for early detection and risk assessment',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.security, color: Colors.white, size: 12),
                      SizedBox(width: 8),
                      Text(
                        'Secure & Confidential',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.people,
            title: 'Users',
            value: '10,000+',
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: AppConstants.defaultPadding),
        Expanded(
          child: _buildStatCard(
            icon: Icons.location_on,
            title: 'Regions',
            value: '16 States',
            color: Colors.green,
          ),
        ),
        const SizedBox(width: AppConstants.defaultPadding),
        Expanded(
          child: _buildStatCard(
            icon: Icons.psychology,
            title: 'Accuracy',
            value: '95%',
            color: Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 14),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            value,
            style: AppConstants.bodyBoldStyle.copyWith(
              color: color,
              fontSize: 12,
            ),
          ),
          Text(
            title,
            style: AppConstants.captionStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepsIndicator(SymptomAnalysisProvider provider) {
    final hasSymptoms =
        provider.fever ||
        provider.bleeding ||
        provider.headache ||
        provider.vomiting;

    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list_alt, color: AppConstants.primaryColor, size: 20),
              const SizedBox(width: AppConstants.smallPadding),
              Text('Assessment Progress', style: AppConstants.subtitleStyle),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Row(
            children: [
              _buildStep(1, 'Report\nSymptoms', hasSymptoms),
              _buildStepConnector(hasSymptoms),
              _buildStep(2, 'Get\nAssessment', provider.result != null),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String title, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          AnimatedContainer(
            duration: AppConstants.shortAnimation,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive ? AppConstants.primaryColor : Colors.grey[300],
              shape: BoxShape.circle,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppConstants.primaryColor.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: isActive
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : Text(
                      '$number',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            title,
            style: AppConstants.captionStyle.copyWith(
              color: isActive ? AppConstants.primaryColor : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(bool isActive) {
    return AnimatedContainer(
      duration: AppConstants.shortAnimation,
      height: 3,
      width: 30,
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: isActive ? AppConstants.primaryColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildDataSummary(SymptomAnalysisProvider provider) {
    final symptomsCount = [
      provider.fever,
      provider.bleeding,
      provider.headache,
      provider.vomiting,
    ].where((s) => s).length;

    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.summarize, color: AppConstants.primaryColor, size: 20),
              const SizedBox(width: AppConstants.smallPadding),
              Text('Data Summary', style: AppConstants.subtitleStyle),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Symptoms',
                  '$symptomsCount/4 reported',
                  symptomsCount > 0 ? AppConstants.warningColor : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppConstants.bodyBoldStyle.copyWith(
            color: color,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppConstants.captionStyle),
      ],
    );
  }

  Widget _buildAnimatedSection({required Widget child, required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + delay),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        // Clamp the value to ensure it stays within valid range
        final clampedValue = value.clamp(0.0, 1.0);
        return Transform.translate(
          offset: Offset(0, 30 * (1 - clampedValue)),
          child: Opacity(opacity: clampedValue, child: child),
        );
      },
      child: child,
    );
  }

  Widget _buildEnhancedSubmitButton(
    BuildContext context,
    SymptomAnalysisProvider provider,
  ) {
    final hasSymptoms =
        provider.fever ||
        provider.bleeding ||
        provider.headache ||
        provider.vomiting;
    final symptomsCount = [
      provider.fever,
      provider.bleeding,
      provider.headache,
      provider.vomiting,
    ].where((s) => s).length;
    //log the data entered by the user on submit
    //first form SymptomData
    final symptomData = SymptomData(
      fever: provider.fever ? 1 : 0,
      bleeding: provider.bleeding ? 1 : 0,
      headache: provider.headache ? 1 : 0,
      vomiting: provider.vomiting ? 1 : 0,
      temperature: provider.temperature.toDouble(),
    );

    //log the symptom data
    print(symptomData.toJson());

    return AnimatedContainer(
      duration: AppConstants.shortAnimation,
      height: AppConstants.buttonHeight + (hasSymptoms ? 12 : 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        boxShadow: [
          BoxShadow(
            color:
                (hasSymptoms
                        ? AppConstants.warningColor
                        : AppConstants.primaryColor)
                    .withOpacity(0.3),
            spreadRadius: hasSymptoms ? 2 : 1,
            blurRadius: hasSymptoms ? 12 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: provider.isLoading
            ? null
            : () {
                provider.submitData(context);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: hasSymptoms
              ? (symptomsCount >= 3
                    ? AppConstants.errorColor
                    : AppConstants.warningColor)
              : AppConstants.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          ),
          elevation: 0,
        ),
        child: provider.isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: AppConstants.smallPadding),
                  Text('Analyzing...', style: TextStyle(fontSize: 16)),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    hasSymptoms
                        ? (symptomsCount >= 3 ? Icons.emergency : Icons.warning)
                        : Icons.psychology,
                    size: 20,
                  ),
                  const SizedBox(width: AppConstants.smallPadding),
                  Text(
                    hasSymptoms
                        ? (symptomsCount >= 3
                              ? 'Urgent Assessment'
                              : 'Priority Assessment')
                        : 'Start Assessment',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHelpSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.blue[100]!.withOpacity(0.3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.help_outline,
                  color: Colors.blue[700],
                  size: 20,
                ),
              ),
              const SizedBox(width: AppConstants.smallPadding),
              Text(
                'Need Help?',
                style: AppConstants.bodyBoldStyle.copyWith(
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            'This tool provides preliminary screening for Lassa fever risk assessment. For medical emergencies, contact local healthcare services immediately.',
            style: AppConstants.bodyStyle.copyWith(color: Colors.blue[700]),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.info),
                  label: const Text('Learn More'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue[700],
                    side: BorderSide(color: Colors.blue[300]!),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.defaultPadding),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.support_agent),
                  label: const Text('Get Support'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue[700],
                    side: BorderSide(color: Colors.blue[300]!),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      },
      backgroundColor: AppConstants.primaryColor,
      child: const Icon(Icons.arrow_upward, color: Colors.white),
      tooltip: 'Scroll to top',
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.help_outline, color: AppConstants.primaryColor),
              const SizedBox(width: 8),
              const Text('How to Use AI4Lassa'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHelpStep(
                  '1. Report Symptoms',
                  'Select any symptoms you are currently experiencing. Be honest and thorough.',
                  Icons.assignment_turned_in,
                ),
                const SizedBox(height: 16),
                _buildHelpStep(
                  '2. Get Assessment',
                  'Click the assessment button to receive an AI-powered risk evaluation.',
                  Icons.psychology,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppConstants.warningColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppConstants.warningColor.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: AppConstants.warningColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Important: This is a screening tool only. Always consult healthcare professionals for medical advice.',
                          style: AppConstants.captionStyle.copyWith(
                            color: AppConstants.warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Got it'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          ),
        );
      },
    );
  }

  Widget _buildHelpStep(String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppConstants.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppConstants.primaryColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppConstants.bodyBoldStyle.copyWith(
                  color: AppConstants.primaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(description, style: AppConstants.captionStyle),
            ],
          ),
        ),
      ],
    );
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.emergency, color: AppConstants.errorColor),
              const SizedBox(width: 8),
              Text(
                'Emergency Contacts',
                style: TextStyle(color: AppConstants.errorColor),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'If you are experiencing severe symptoms, seek immediate medical attention:',
                style: AppConstants.bodyStyle,
              ),
              const SizedBox(height: 16),
              _buildEmergencyContact(
                'Emergency Hotline',
                '08000000000',
                Icons.phone,
                () {
                  // TODO: Make emergency call
                },
              ),
              const SizedBox(height: 12),
              _buildEmergencyContact(
                'Nearest Hospital',
                'Find nearby medical facilities',
                Icons.local_hospital,
                () {
                  // TODO: Open maps to nearest hospital
                },
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppConstants.errorColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Severe symptoms include: difficulty breathing, severe bleeding, high fever (>40°C), or loss of consciousness.',
                  style: AppConstants.captionStyle.copyWith(
                    color: AppConstants.errorColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          ),
        );
      },
    );
  }

  Widget _buildEmergencyContact(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppConstants.errorColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppConstants.errorColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppConstants.bodyBoldStyle.copyWith(
                      color: AppConstants.errorColor,
                    ),
                  ),
                  Text(subtitle, style: AppConstants.captionStyle),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppConstants.errorColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
