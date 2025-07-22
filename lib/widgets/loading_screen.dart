import 'package:flutter/material.dart';
import '../utils/constants.dart';

class LoadingScreen extends StatelessWidget {
  final String message;
  const LoadingScreen({super.key, this.message = 'Analyzing your data...'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _HeartbeatPulse(),
            const SizedBox(height: 32),
            Text(
              message,
              style: AppConstants.titleStyle.copyWith(
                color: AppConstants.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Please wait while we process your information.',
              style: AppConstants.bodyStyle.copyWith(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeartbeatPulse extends StatefulWidget {
  const _HeartbeatPulse();

  @override
  State<_HeartbeatPulse> createState() => _HeartbeatPulseState();
}

class _HeartbeatPulseState extends State<_HeartbeatPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 1.35,
    ).chain(CurveTween(curve: Curves.easeInOutCubic)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: Icon(
        Icons.favorite,
        color: AppConstants.primaryColor,
        size: 90,
        shadows: [
          Shadow(
            color: AppConstants.primaryColor.withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );
  }
}
