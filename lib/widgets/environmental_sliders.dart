import 'package:flutter/material.dart';
import '../utils/constants.dart';

class EnvironmentalSliders extends StatefulWidget {
  final double initialHumidity;
  final double initialTemperature;
  final Function(double) onHumidityChanged;
  final Function(double) onTemperatureChanged;

  const EnvironmentalSliders({
    super.key,
    this.initialHumidity = AppConstants.defaultHumidity,
    this.initialTemperature = AppConstants.defaultTemperature,
    required this.onHumidityChanged,
    required this.onTemperatureChanged,
  });

  @override
  State<EnvironmentalSliders> createState() => _EnvironmentalSlidersState();
}

class _EnvironmentalSlidersState extends State<EnvironmentalSliders> {
  late double _humidity;
  late double _temperature;

  @override
  void initState() {
    super.initState();
    _humidity = widget.initialHumidity;
    _temperature = widget.initialTemperature;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
          child: Text('Environmental Data', style: AppConstants.subtitleStyle),
        ),

        // Humidity Slider
        _buildSliderSection(
          title: 'Humidity',
          value: _humidity,
          min: AppConstants.minHumidity,
          max: AppConstants.maxHumidity,
          unit: '%',
          icon: Icons.water_drop,
          color: AppConstants.secondaryColor,
          onChanged: (value) {
            setState(() {
              _humidity = value;
            });
            widget.onHumidityChanged(value);
          },
        ),

        const SizedBox(height: AppConstants.largePadding),

        // Temperature Slider
        _buildSliderSection(
          title: 'Temperature',
          value: _temperature,
          min: AppConstants.minTemperature,
          max: AppConstants.maxTemperature,
          unit: '°C',
          icon: Icons.thermostat,
          color: AppConstants.warningColor,
          onChanged: (value) {
            setState(() {
              _temperature = value;
            });
            widget.onTemperatureChanged(value);
          },
        ),
      ],
    );
  }

  Widget _buildSliderSection({
    required String title,
    required double value,
    required double min,
    required double max,
    required String unit,
    required IconData icon,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: AppConstants.smallPadding),
              Text(
                title,
                style: AppConstants.bodyStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${value.toStringAsFixed(1)}$unit',
                style: AppConstants.bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.smallPadding),

          // Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: AppConstants.sliderTrackHeight,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: AppConstants.sliderThumbRadius,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
              activeTrackColor: color,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: color,
              overlayColor: color.withOpacity(0.2),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: ((max - min) / 0.5).round(),
              onChanged: onChanged,
            ),
          ),

          // Min/Max labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${min.toStringAsFixed(0)}$unit',
                style: AppConstants.captionStyle,
              ),
              Text(
                '${max.toStringAsFixed(0)}$unit',
                style: AppConstants.captionStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
