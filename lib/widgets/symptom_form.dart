import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SymptomForm extends StatefulWidget {
  final bool initialFever;
  final bool initialBleeding;
  final bool initialHeadache;
  final bool initialVomiting;
  final Function(bool) onFeverChanged;
  final Function(bool) onBleedingChanged;
  final Function(bool) onHeadacheChanged;
  final Function(bool) onVomitingChanged;

  const SymptomForm({
    super.key,
    this.initialFever = false,
    this.initialBleeding = false,
    this.initialHeadache = false,
    this.initialVomiting = false,
    required this.onFeverChanged,
    required this.onBleedingChanged,
    required this.onHeadacheChanged,
    required this.onVomitingChanged,
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

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _fever = widget.initialFever;
    _bleeding = widget.initialBleeding;
    _headache = widget.initialHeadache;
    _vomiting = widget.initialVomiting;

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

              // Fever Checkbox
              _buildEnhancedSymptomCheckbox(
                title: 'Fever',
                description: 'Body temperature above 37.5°C (99.5°F)',
                detailText: 'High fever is a key symptom of Lassa fever',
                value: _fever,
                icon: Icons.thermostat,
                color: AppConstants.warningColor,
                severity: SymptomSeverity.high,
                onChanged: (value) {
                  setState(() {
                    _fever = value;
                  });
                  widget.onFeverChanged(value);
                  if (value) _animateSelection();
                },
              ),

              const SizedBox(height: AppConstants.defaultPadding),

              // Bleeding Checkbox
              _buildEnhancedSymptomCheckbox(
                title: 'Bleeding',
                description: 'Unusual bleeding or hemorrhage',
                detailText: 'May include nosebleeds, gum bleeding, or bruising',
                value: _bleeding,
                icon: Icons.bloodtype,
                color: AppConstants.errorColor,
                severity: SymptomSeverity.critical,
                onChanged: (value) {
                  setState(() {
                    _bleeding = value;
                  });
                  widget.onBleedingChanged(value);
                  if (value) _animateSelection();
                },
              ),

              const SizedBox(height: AppConstants.defaultPadding),

              // Headache Checkbox
              _buildEnhancedSymptomCheckbox(
                title: 'Headache',
                description: 'Persistent or severe headache',
                detailText: 'Often described as intense and throbbing',
                value: _headache,
                icon: Icons.psychology,
                color: Colors.deepPurple,
                severity: SymptomSeverity.medium,
                onChanged: (value) {
                  setState(() {
                    _headache = value;
                  });
                  widget.onHeadacheChanged(value);
                  if (value) _animateSelection();
                },
              ),

              const SizedBox(height: AppConstants.defaultPadding),

              // Vomiting Checkbox
              _buildEnhancedSymptomCheckbox(
                title: 'Vomiting',
                description: 'Nausea, vomiting, or stomach upset',
                detailText: 'May be accompanied by loss of appetite',
                value: _vomiting,
                icon: Icons.sick,
                color: Colors.teal,
                severity: SymptomSeverity.medium,
                onChanged: (value) {
                  setState(() {
                    _vomiting = value;
                  });
                  widget.onVomitingChanged(value);
                  if (value) _animateSelection();
                },
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

  Widget _buildEnhancedSymptomCheckbox({
    required String title,
    required String description,
    required String detailText,
    required bool value,
    required IconData icon,
    required Color color,
    required SymptomSeverity severity,
    required ValueChanged<bool> onChanged,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: value ? color.withOpacity(0.1) : Colors.grey[50],
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(
          color: value ? color : Colors.grey[300]!,
          width: value ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Icon with severity indicator
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      AppConstants.smallPadding + 2,
                    ),
                    decoration: BoxDecoration(
                      color: value ? color : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: value ? Colors.white : Colors.grey[600],
                      size: 24,
                    ),
                  ),
                  if (severity == SymptomSeverity.critical && value)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppConstants.errorColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: AppConstants.defaultPadding),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: AppConstants.bodyStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: value ? color : Colors.black87,
                          ),
                        ),
                        if (severity == SymptomSeverity.critical) ...[
                          const SizedBox(width: AppConstants.smallPadding),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppConstants.errorColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'CRITICAL',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
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

              // Checkbox
              Transform.scale(
                scale: value ? 1.1 : 1.0,
                child: Checkbox(
                  value: value,
                  onChanged: (bool? newValue) => onChanged(newValue ?? false),
                  activeColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),

          // Additional details when selected
          if (value) ...[
            const SizedBox(height: AppConstants.smallPadding),
            Container(
              padding: const EdgeInsets.all(AppConstants.smallPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: color, size: 16),
                  const SizedBox(width: AppConstants.smallPadding),
                  Expanded(
                    child: Text(
                      detailText,
                      style: AppConstants.captionStyle.copyWith(
                        color: color.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
