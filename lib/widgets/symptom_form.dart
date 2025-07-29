import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SymptomForm extends StatefulWidget {
  final bool initialFever;
  final bool initialBleeding;
  final bool initialHeadache;
  final bool initialVomiting;
  final double initialTemperature;
  final Function(bool) onFeverChanged;
  final Function(bool) onBleedingChanged;
  final Function(bool) onHeadacheChanged;
  final Function(bool) onVomitingChanged;
  final Function(double) onTemperatureChanged;

  const SymptomForm({
    super.key,
    this.initialFever = false,
    this.initialBleeding = false,
    this.initialHeadache = false,
    this.initialVomiting = false,
    this.initialTemperature = 37.0,
    required this.onFeverChanged,
    required this.onBleedingChanged,
    required this.onHeadacheChanged,
    required this.onVomitingChanged,
    required this.onTemperatureChanged,
  });

  @override
  State<SymptomForm> createState() => _SymptomFormState();
}

class _SymptomFormState extends State<SymptomForm>
    with TickerProviderStateMixin {
  late bool _fever;
  late bool _bleeding;
  late bool _headache;
  late bool _vomiting;
  late double _temperature;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _fever = widget.initialFever;
    _bleeding = widget.initialBleeding;
    _headache = widget.initialHeadache;
    _vomiting = widget.initialVomiting;
    _temperature = widget.initialTemperature;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = [
      _fever,
      _bleeding,
      _headache,
      _vomiting,
    ].where((symptom) => symptom).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with Count
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
          child: Row(
            children: [
              Text('Symptoms', style: AppConstants.subtitleStyle),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.smallPadding,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: selectedCount > 0
                      ? AppConstants.warningColor.withOpacity(0.1)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedCount > 0
                        ? AppConstants.warningColor
                        : Colors.grey[400]!,
                  ),
                ),
                child: Text(
                  '$selectedCount/4 selected',
                  style: AppConstants.captionStyle.copyWith(
                    color: selectedCount > 0
                        ? AppConstants.warningColor
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Symptoms Container
        Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
            border: Border.all(
              color: selectedCount > 0
                  ? AppConstants.warningColor.withOpacity(0.3)
                  : Colors.grey[300]!,
              width: selectedCount > 0 ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: selectedCount > 0
                    ? AppConstants.warningColor.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Quick Assessment Text
              if (selectedCount > 0) ...[
                Container(
                  padding: const EdgeInsets.all(AppConstants.smallPadding),
                  decoration: BoxDecoration(
                    color: AppConstants.warningColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: AppConstants.warningColor,
                        size: 16,
                      ),
                      const SizedBox(width: AppConstants.smallPadding),
                      Expanded(
                        child: Text(
                          selectedCount >= 3
                              ? 'Multiple symptoms detected - urgent assessment recommended'
                              : 'Symptoms reported - assessment recommended',
                          style: AppConstants.captionStyle.copyWith(
                            color: AppConstants.warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.defaultPadding),
              ],

              // Fever Switch
              _buildSymptomSwitch(
                title: 'Fever',
                description: 'Elevated body temperature',
                value: _fever,
                icon: Icons.thermostat,
                color: AppConstants.warningColor,
                onChanged: (value) {
                  setState(() {
                    _fever = value;
                  });
                  widget.onFeverChanged(value);
                },
              ),

              const SizedBox(height: AppConstants.defaultPadding),

              // Bleeding Switch
              _buildSymptomSwitch(
                title: 'Bleeding',
                description: 'Unusual bleeding or hemorrhage',
                value: _bleeding,
                icon: Icons.bloodtype,
                color: AppConstants.errorColor,
                onChanged: (value) {
                  setState(() {
                    _bleeding = value;
                  });
                  widget.onBleedingChanged(value);
                },
              ),

              const SizedBox(height: AppConstants.defaultPadding),

              // Headache Switch
              _buildSymptomSwitch(
                title: 'Headache',
                description: 'Persistent or severe headache',
                value: _headache,
                icon: Icons.psychology,
                color: Colors.deepPurple,
                onChanged: (value) {
                  setState(() {
                    _headache = value;
                  });
                  widget.onHeadacheChanged(value);
                },
              ),

              const SizedBox(height: AppConstants.defaultPadding),

              // Vomiting Switch
              _buildSymptomSwitch(
                title: 'Vomiting',
                description: 'Nausea or vomiting',
                value: _vomiting,
                icon: Icons.sick,
                color: Colors.teal,
                onChanged: (value) {
                  setState(() {
                    _vomiting = value;
                  });
                  widget.onVomitingChanged(value);
                },
              ),

              const SizedBox(height: AppConstants.defaultPadding),

              // Temperature Input
              Container(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppConstants.buttonRadius,
                  ),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(
                            AppConstants.smallPadding,
                          ),
                          decoration: BoxDecoration(
                            color: AppConstants.warningColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.thermostat,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: AppConstants.defaultPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Body Temperature',
                                style: AppConstants.bodyStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Enter your body temperature in °C',
                                style: AppConstants.captionStyle.copyWith(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: _temperature,
                            min: 35.0,
                            max: 42.0,
                            divisions: 70,
                            label: '${_temperature.toStringAsFixed(1)}°C',
                            onChanged: (value) {
                              setState(() {
                                _temperature = value;
                              });
                              widget.onTemperatureChanged(value);
                            },
                          ),
                        ),
                        const SizedBox(width: AppConstants.defaultPadding),
                        Text(
                          '${_temperature.toStringAsFixed(1)}°C',
                          style: AppConstants.bodyStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppConstants.warningColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Additional Information
        const SizedBox(height: AppConstants.defaultPadding),
        Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
              const SizedBox(width: AppConstants.smallPadding),
              Expanded(
                child: Text(
                  'Select all symptoms you are currently experiencing. Early symptoms may be mild and similar to other illnesses.',
                  style: AppConstants.captionStyle.copyWith(
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSymptomSwitch({
    required String title,
    required String description,
    required bool value,
    required IconData icon,
    required Color color,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: value ? color.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(
          color: value ? color : Colors.grey[300]!,
          width: value ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(AppConstants.smallPadding),
            decoration: BoxDecoration(
              color: value ? color : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: value ? Colors.white : Colors.grey[600],
              size: 20,
            ),
          ),
          const SizedBox(width: AppConstants.defaultPadding),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppConstants.bodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: value ? color : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppConstants.captionStyle.copyWith(
                    color: value ? color.withOpacity(0.8) : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          // Switch
          Switch(value: value, onChanged: onChanged, activeColor: color),
        ],
      ),
    );
  }

  void _animateSelection() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }
}

enum SymptomSeverity { low, medium, high, critical }
