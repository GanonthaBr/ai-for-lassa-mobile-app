import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _dataCollection = false;
  bool _autoSave = true;
  bool _biometricAuth = false;
  String _language = 'English';
  String _temperatureUnit = 'Celsius';
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
      _dataCollection = prefs.getBool('data_collection') ?? false;
      _autoSave = prefs.getBool('auto_save') ?? true;
      _biometricAuth = prefs.getBool('biometric_auth') ?? false;
      _language = prefs.getString('language') ?? 'English';
      _temperatureUnit = prefs.getString('temperature_unit') ?? 'Celsius';
      _darkMode = prefs.getBool('dark_mode') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', _notificationsEnabled);
    await prefs.setBool('data_collection', _dataCollection);
    await prefs.setBool('auto_save', _autoSave);
    await prefs.setBool('biometric_auth', _biometricAuth);
    await prefs.setString('language', _language);
    await prefs.setString('temperature_unit', _temperatureUnit);
    await prefs.setBool('dark_mode', _darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Preferences Section
            _buildSectionHeader('App Preferences'),
            _buildSettingsCard([
              _buildSwitchTile(
                title: 'Push Notifications',
                subtitle: 'Receive health reminders and updates',
                value: _notificationsEnabled,
                icon: Icons.notifications,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                  _saveSettings();
                },
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                title: 'Auto-save Results',
                subtitle: 'Automatically save assessment results',
                value: _autoSave,
                icon: Icons.save,
                onChanged: (value) {
                  setState(() {
                    _autoSave = value;
                  });
                  _saveSettings();
                },
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                title: 'Dark Mode',
                subtitle: 'Use dark theme for the app',
                value: _darkMode,
                icon: Icons.dark_mode,
                onChanged: (value) {
                  setState(() {
                    _darkMode = value;
                  });
                  _saveSettings();
                  // TODO: Implement theme switching
                },
              ),
            ]),

            const SizedBox(height: AppConstants.largePadding),

            // Privacy & Security Section
            _buildSectionHeader('Privacy & Security'),
            _buildSettingsCard([
              _buildSwitchTile(
                title: 'Biometric Authentication',
                subtitle: 'Use fingerprint or face unlock',
                value: _biometricAuth,
                icon: Icons.fingerprint,
                onChanged: (value) {
                  setState(() {
                    _biometricAuth = value;
                  });
                  _saveSettings();
                },
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                title: 'Anonymous Data Collection',
                subtitle: 'Help improve AI accuracy (no personal data)',
                value: _dataCollection,
                icon: Icons.analytics,
                onChanged: (value) {
                  setState(() {
                    _dataCollection = value;
                  });
                  _saveSettings();
                },
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'Privacy Policy',
                subtitle: 'View our privacy policy',
                icon: Icons.privacy_tip,
                onTap: () {
                  // TODO: Open privacy policy
                },
                trailing: const Icon(Icons.open_in_new),
              ),
            ]),

            const SizedBox(height: AppConstants.largePadding),

            // Preferences Section
            _buildSectionHeader('Preferences'),
            _buildSettingsCard([
              _buildDropdownTile(
                title: 'Language',
                subtitle: 'App display language',
                icon: Icons.language,
                value: _language,
                items: ['English', 'French', 'Hausa', 'Yoruba', 'Igbo'],
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                  });
                  _saveSettings();
                },
              ),
              const Divider(height: 1),
              _buildDropdownTile(
                title: 'Temperature Unit',
                subtitle: 'Display temperature in',
                icon: Icons.thermostat,
                value: _temperatureUnit,
                items: ['Celsius', 'Fahrenheit'],
                onChanged: (value) {
                  setState(() {
                    _temperatureUnit = value!;
                  });
                  _saveSettings();
                },
              ),
            ]),

            const SizedBox(height: AppConstants.largePadding),

            // Data Management Section
            _buildSectionHeader('Data Management'),
            _buildSettingsCard([
              _buildListTile(
                title: 'Assessment History',
                subtitle: 'View your previous assessments',
                icon: Icons.history,
                onTap: () {
                  // TODO: Navigate to history screen
                },
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'Export Data',
                subtitle: 'Download your data as PDF',
                icon: Icons.file_download,
                onTap: () {
                  _exportData();
                },
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'Clear Data',
                subtitle: 'Delete all stored assessments',
                icon: Icons.delete,
                onTap: () {
                  _showClearDataDialog();
                },
                trailing: const Icon(Icons.arrow_forward_ios),
                textColor: AppConstants.errorColor,
              ),
            ]),

            const SizedBox(height: AppConstants.largePadding),

            // About Section
            _buildSectionHeader('About'),
            _buildSettingsCard([
              _buildListTile(
                title: 'App Version',
                subtitle: AppConstants.appVersion,
                icon: Icons.info,
                onTap: () {
                  _showVersionDialog();
                },
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'Check for Updates',
                subtitle: 'Look for app updates',
                icon: Icons.system_update,
                onTap: () {
                  _checkForUpdates();
                },
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'Terms of Service',
                subtitle: 'Review terms and conditions',
                icon: Icons.description,
                onTap: () {
                  // TODO: Open terms of service
                },
                trailing: const Icon(Icons.open_in_new),
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'Send Feedback',
                subtitle: 'Help us improve the app',
                icon: Icons.feedback,
                onTap: () {
                  // TODO: Open feedback form
                },
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ]),

            const SizedBox(height: AppConstants.largePadding),

            // Emergency Contacts Section
            _buildSectionHeader('Emergency'),
            _buildSettingsCard([
              _buildListTile(
                title: 'Emergency Hotline',
                subtitle: AppConstants.emergencyHotline,
                icon: Icons.emergency,
                onTap: () {
                  // TODO: Make emergency call
                },
                trailing: const Icon(Icons.phone),
                textColor: AppConstants.errorColor,
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'Nearest Health Facility',
                subtitle: 'Find nearby medical centers',
                icon: Icons.local_hospital,
                onTap: () {
                  // TODO: Open maps to nearest facility
                },
                trailing: const Icon(Icons.location_on),
              ),
            ]),

            const SizedBox(height: AppConstants.extraLargePadding),

            // Reset Settings Button
            Center(
              child: OutlinedButton.icon(
                onPressed: _resetAllSettings,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset All Settings'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppConstants.warningColor,
                  side: BorderSide(color: AppConstants.warningColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppConstants.smallPadding,
        bottom: AppConstants.smallPadding,
      ),
      child: Text(
        title,
        style: AppConstants.subtitleStyle.copyWith(
          color: AppConstants.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
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
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppConstants.primaryColor),
      title: Text(title, style: AppConstants.bodyStyle),
      subtitle: Text(subtitle, style: AppConstants.captionStyle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppConstants.primaryColor,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    Widget? trailing,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppConstants.primaryColor),
      title: Text(
        title,
        style: AppConstants.bodyStyle.copyWith(
          color: textColor ?? AppConstants.textPrimary,
        ),
      ),
      subtitle: Text(subtitle, style: AppConstants.captionStyle),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppConstants.primaryColor),
      title: Text(title, style: AppConstants.bodyStyle),
      subtitle: Text(subtitle, style: AppConstants.captionStyle),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        items: items.map((String item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
    );
  }

  void _exportData() {
    // TODO: Implement data export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Data export feature coming soon'),
        backgroundColor: AppConstants.infoColor,
      ),
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Data'),
          content: const Text(
            'This will permanently delete all your assessment history and cannot be undone. Are you sure?',
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: AppConstants.errorColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _clearAllData();
              },
            ),
          ],
        );
      },
    );
  }

  void _clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.assessmentHistoryKey);
    await prefs.remove(AppConstants.lastAssessmentKey);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('All data cleared successfully'),
        backgroundColor: AppConstants.successColor,
      ),
    );
  }

  void _showVersionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppConstants.appName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Version: ${AppConstants.appVersion}'),
              const SizedBox(height: 8),
              Text(AppConstants.appDescription),
              const SizedBox(height: 16),
              Text('© 2025 AI4Lassa Team'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _checkForUpdates() {
    // TODO: Implement update checking
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('You have the latest version'),
        backgroundColor: AppConstants.successColor,
      ),
    );
  }

  void _resetAllSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Settings'),
          content: const Text(
            'This will reset all settings to their default values. Continue?',
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                'Reset',
                style: TextStyle(color: AppConstants.warningColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _performReset();
              },
            ),
          ],
        );
      },
    );
  }

  void _performReset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      _notificationsEnabled = true;
      _dataCollection = false;
      _autoSave = true;
      _biometricAuth = false;
      _language = 'English';
      _temperatureUnit = 'Celsius';
      _darkMode = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Settings reset to defaults'),
        backgroundColor: AppConstants.successColor,
      ),
    );
  }
}
