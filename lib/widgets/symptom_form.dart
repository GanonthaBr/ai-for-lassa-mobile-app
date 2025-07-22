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

class _SymptomFormState extends State<SymptomForm> {
  late bool _fever;
  late bool _bleeding;
  late bool _headache;
  late bool _vomiting;

  @override
  void initState() {
    super.initState();
    _fever = widget.initialFever;
    _bleeding = widget.initialBleeding;
    _headache = widget.initialHeadache;
    _vomiting = widget.initialVomiting;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
          child: Text('Symptoms', style: AppConstants.subtitleStyle),
        ),

        // Symptoms Container
        Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: [
              // Fever Checkbox
              _buildSymptomCheckbox(
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

              // Bleeding Checkbox
              _buildSymptomCheckbox(
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

              // Headache Checkbox
              _buildSymptomCheckbox(
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

              // Vomiting Checkbox
              _buildSymptomCheckbox(
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSymptomCheckbox({
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

          // Checkbox
          Checkbox(
            value: value,
            onChanged: (bool? newValue) => onChanged(newValue ?? false),
            activeColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
