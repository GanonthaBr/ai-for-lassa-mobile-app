# AI4Lassa - Lassa Fever Detection App

A Flutter mobile application for early detection of Lassa Fever outbreaks through symptom and environmental data reporting.

## Features

- **Symptom Reporting**: Toggle switches for fever and bleeding symptoms
- **Environmental Data**: Sliders for humidity (0-100%) and temperature (20-50°C)
- **Risk Assessment**: AI-powered risk level prediction (High/Low)
- **Network Integration**: JSON payload submission to Flask backend
- **Error Handling**: Comprehensive error handling for network issues
- **Modern UI**: Clean, intuitive interface with Material Design

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── symptom_data.dart     # Data model for symptoms
│   └── prediction_result.dart # API response model
├── services/
│   └── api_service.dart      # HTTP API integration
├── screens/
│   └── home_screen.dart      # Main application screen
├── widgets/
│   ├── symptom_form.dart     # Symptom input widgets
│   ├── environmental_sliders.dart # Environmental data sliders
│   └── result_display.dart   # Result display widget
└── utils/
    └── constants.dart        # App constants and styling
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Android Studio / VS Code
- Android device or emulator

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd ai4lassa
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure API endpoint**

   Edit `lib/services/api_service.dart`:

   ```dart
   // For testing with NGrok
   static const String _testingNgrokUrl = 'https://your-ngrok-url.ngrok.io';

   // For production (local network)
   static const String _productionIp = 'http://192.168.1.100:5000';
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Configuration

### Network Configuration

The app supports two deployment modes:

#### Testing Mode (NGrok)

- Backend team exposes Flask app via NGrok
- Mobile app connects to NGrok URL
- Used during development and testing

#### Production Mode (Local Network)

- Backend runs on local network IP
- Mobile app connects directly to local IP
- No internet required - works offline

### API Configuration

Update the following constants in `lib/services/api_service.dart`:

```dart
// Set to false for production deployment
static const bool _useNgrokForTesting = true;

// Update with your backend IP for production
static const String _productionIp = 'http://192.168.1.100:5000';

// Update with your NGrok URL for testing
static const String _testingNgrokUrl = 'https://your-ngrok-url.ngrok.io';
```

## Usage

1. **Launch the app** - The main screen displays the symptom reporting form
2. **Select symptoms** - Toggle fever and bleeding checkboxes
3. **Adjust environmental data** - Use sliders for humidity and temperature
4. **Submit for analysis** - Tap "Submit for Analysis" button
5. **View results** - Risk level and recommendations are displayed

## API Integration

### Request Format

```json
{
  "fever": true,
  "bleeding": false,
  "humidity": 65.0,
  "temperature": 28.5
}
```

### Response Format

```json
{
  "risk_level": "High",
  "confidence": 0.85,
  "timestamp": "2025-07-13T10:30:00Z"
}
```

## Error Handling

The app handles various error scenarios:

- Network connectivity issues
- Server unavailability
- Invalid response formats
- Timeout scenarios

Error messages are displayed to users with appropriate guidance.

## Dependencies

- `http: ^1.1.0` - HTTP requests for API calls
- `provider: ^6.0.5` - State management
- `shared_preferences: ^2.2.2` - Local storage

## Development

### Building for Production

```bash
# Android APK
flutter build apk --release

# iOS (requires macOS)
flutter build ios --release
```

### Testing

```bash
# Run tests
flutter test

# Analyze code
flutter analyze
```

## Deployment

### Local Network Deployment

1. **Backend Setup**

   - Run Flask app on known local IP (e.g., 192.168.1.100:5000)
   - Ensure both devices are on same Wi-Fi network

2. **Mobile App Configuration**

   - Update `_productionIp` in `api_service.dart`
   - Set `_useNgrokForTesting = false`
   - Build and install app on target devices

3. **Network Validation**
   - Test connectivity between mobile and backend
   - Verify API endpoints are accessible

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For technical support or questions, please contact the development team.
