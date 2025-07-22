// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai4lassa/main.dart';
import 'package:ai4lassa/models/symptom_data.dart';
import 'package:ai4lassa/models/prediction_result.dart';

void main() {
  group('AI4Lassa App Tests', () {
    testWidgets('App should start without crashing', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that the app starts successfully
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    test('SymptomData model should work correctly', () {
      final symptomData = SymptomData(
        fever: true,
        bleeding: false,
        humidity: 65.0,
        temperature: 28.5,
      );

      expect(symptomData.fever, true);
      expect(symptomData.bleeding, false);
      expect(symptomData.humidity, 65.0);
      expect(symptomData.temperature, 28.5);

      // Test JSON serialization
      final json = symptomData.toJson();
      expect(json['fever'], true);
      expect(json['bleeding'], false);
      expect(json['humidity'], 65.0);
      expect(json['temperature'], 28.5);
    });

    test('PredictionResult model should work correctly', () {
      final result = PredictionResult(
        riskLevel: 'High',
        confidence: 0.85,
        timestamp: DateTime(2025, 7, 13, 10, 30),
      );

      expect(result.riskLevel, 'High');
      expect(result.confidence, 0.85);
      expect(result.isHighRisk, true);
      expect(result.confidencePercentage, 85);

      // Test JSON deserialization
      final json = {
        'risk_level': 'Low',
        'confidence': 0.75,
        'timestamp': '2025-07-13T10:30:00Z',
      };

      final fromJsonResult = PredictionResult.fromJson(json);
      expect(fromJsonResult.riskLevel, 'Low');
      expect(fromJsonResult.confidence, 0.75);
      expect(fromJsonResult.isHighRisk, false);
      expect(fromJsonResult.confidencePercentage, 75);
    });

    test('SymptomData copyWith should work correctly', () {
      final original = SymptomData(
        fever: false,
        bleeding: false,
        humidity: 50.0,
        temperature: 25.0,
      );

      final updated = original.copyWith(fever: true, temperature: 30.0);

      expect(updated.fever, true);
      expect(updated.bleeding, false); // unchanged
      expect(updated.humidity, 50.0); // unchanged
      expect(updated.temperature, 30.0);
    });
  });
}
