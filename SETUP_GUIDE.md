# 📖 Complete Setup Guide for Whispering Shadows

## 🎯 Prerequisites

Before you begin, ensure you have:
- **Flutter SDK 3.0+** installed
- **Dart SDK** (comes with Flutter)
- **Android Studio** or **Xcode** (for mobile development)
- **Firebase account** (free tier works)
- **OpenAI API account** with credits

## 📥 Step 1: Clone & Install

```bash
# Clone the repository
git clone https://github.com/gaurav2431/whispering-shadows-app.git
cd whispering-shadows-app

# Install Flutter dependencies
flutter pub get

# Verify Flutter installation
flutter doctor
```

## 🔥 Step 2: Firebase Setup

### Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click **"Add project"**
3. Name it **"Whispering Shadows"**
4. Enable/disable Google Analytics (optional)
5. Click **"Create project"**

### Add Android App

1. In Firebase Console, click the **Android icon**
2. **Package name**: `com.example.whispering_shadows`
3. **App nickname**: Whispering Shadows (optional)
4. Click **"Register app"**
5. **Download** `google-services.json`
6. Place it in: `android/app/google-services.json`
7. Follow the Firebase setup instructions (already configured in this project)

### Add iOS App

1. In Firebase Console, click the **iOS icon**
2. **Bundle ID**: `com.example.whisperingShadows`
3. **App nickname**: Whispering Shadows (optional)
4. Click **"Register app"**
5. **Download** `GoogleService-Info.plist`
6. Place it in: `ios/Runner/GoogleService-Info.plist`
7. Follow the Firebase setup instructions

### Enable Firestore Database

1. In Firebase Console, go to **"Firestore Database"**
2. Click **"Create database"**
3. Choose **"Start in test mode"** (for development)
4. Select your preferred **location**
5. Click **"Enable"**

### Firestore Security Rules (Production)

For production, update your Firestore rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Readings collection
    match /readings/{reading} {
      allow read, write: if request.auth != null 
        && request.auth.uid == resource.data.userId;
    }
    
    // User chat history
    match /users/{userId}/chat_history/{message} {
      allow read, write: if request.auth != null 
        && request.auth.uid == userId;
    }
  }
}
```

## 🤖 Step 3: OpenAI API Setup

### Get Your API Key

1. Go to [OpenAI Platform](https://platform.openai.com)
2. Sign up or log in
3. Navigate to **API Keys** section
4. Click **"Create new secret key"**
5. **Copy the key** (you won't see it again!)

### Add API Key to Project

Open `lib/services/openai_service.dart` and replace:

```dart
static const String _apiKey = 'YOUR_OPENAI_API_KEY_HERE';
```

With your actual key:

```dart
static const String _apiKey = 'sk-proj-xxxxxxxxxxxxx';
```

### Choose Your Model

In the same file, you can choose between:

```dart
static const String _model = 'gpt-4'; // Higher quality, more expensive
// OR
static const String _model = 'gpt-3.5-turbo'; // Faster, cheaper
```

⚠️ **SECURITY WARNING**: Never commit API keys to version control! For production, use environment variables.

## 🏃 Step 4: Run the App

### On Android Emulator/Device

```bash
# List available devices
flutter devices

# Run on Android
flutter run -d android
```

### On iOS Simulator/Device

```bash
# Run on iOS
flutter run -d ios
```

### On Web (for UI testing only)

```bash
flutter run -d chrome
```

## ✅ Step 5: Test Features

### Test Tarot Reading

1. Launch the app
2. Tap **"Tarot Reading"**
3. (Optional) Enter a question
4. Tap **"Draw Cards"**
5. Wait for AI to generate interpretations
6. Check Firebase Console to see the reading saved

### Test Ghost Chat

1. Tap **"Ghost Chat"**
2. Send a message to the ghost
3. Receive a cryptic, spooky response
4. Check Firebase for chat history

### Test Reading History

1. Tap **"Past Readings"**
2. View your saved readings
3. Tap any reading to see full details

## 🔧 Troubleshooting

### Firebase Connection Issues

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### OpenAI API Errors

**Error: 401 Unauthorized**
- Check that your API key is correct
- Verify you have credits in your OpenAI account

**Error: 429 Rate Limit**
- You've exceeded your API quota
- Wait or upgrade your OpenAI plan

### Build Errors

```bash
# Update all dependencies
flutter pub upgrade

# Check Flutter version
flutter --version

# If needed, upgrade Flutter
flutter upgrade
```

### Android Build Issues

```bash
cd android
./gradlew clean
cd ..
flutter run
```

### iOS Build Issues

```bash
cd ios
pod install
cd ..
flutter run
```

## 🚀 Production Deployment

### 1. Secure Your API Key

**Option A: Environment Variables**

Create `.env` file:
```
OPENAI_API_KEY=sk-proj-xxxxx
```

Add to `pubspec.yaml`:
```yaml
dependencies:
  flutter_dotenv: ^5.1.0
```

Update `openai_service.dart`:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

static final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
```

**Option B: Backend Proxy (Recommended)**

Create a backend service (Node.js, Python, etc.) that:
- Receives requests from your app
- Calls OpenAI API with your key
- Returns responses to your app

This keeps your API key completely secure!

### 2. Implement Firebase Authentication

Add to `pubspec.yaml`:
```yaml
dependencies:
  firebase_auth: ^4.15.3
```

Update `firebase_service.dart` to use `FirebaseAuth.instance.currentUser.uid` instead of `'demo_user'`.

### 3. Update Firestore Security Rules

See the production rules in Step 2 above.

### 4. Build Release Versions

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle (for Play Store):**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

### 5. App Store Submission

- Configure app icons and splash screens
- Update `pubspec.yaml` version number
- Follow platform-specific guidelines:
  - [Google Play Console](https://play.google.com/console)
  - [Apple App Store Connect](https://appstoreconnect.apple.com)

## 🎨 Customization

### Change Theme Colors

Edit `lib/main.dart`:

```dart
primaryColor: const Color(0xFF6A0DAD), // Your color
secondary: const Color(0xFF9D4EDD), // Your color
```

### Modify Ghost Personality

Edit `lib/services/openai_service.dart`:

```dart
static const String _ghostSystemPrompt = '''
Your custom ghost personality here...
''';
```

### Add Custom Tarot Cards

Edit `lib/services/tarot_service.dart` in `_createMajorArcana()` or `_createMinorArcana()`.

## 🔮 Future Enhancements

### Add AR Ghost Portals

```yaml
# pubspec.yaml
dependencies:
  ar_flutter_plugin: ^0.7.3
```

```dart
// Create AR screen
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';

class ARGhostPortal extends StatefulWidget {
  // Implement AR visualization
}
```

### Add Voice Chat

```yaml
dependencies:
  speech_to_text: ^6.5.1
  flutter_tts: ^3.8.3
```

### Add Sound Effects

```yaml
dependencies:
  audioplayers: ^5.2.1
```

Add spooky ambient sounds and card shuffle effects!

### Daily Notifications

```yaml
dependencies:
  flutter_local_notifications: ^16.3.0
```

Send daily tarot card notifications.

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- [OpenAI API Documentation](https://platform.openai.com/docs)
- [Tarot Card Meanings](https://www.biddytarot.com/tarot-card-meanings/)

## 🆘 Getting Help

If you encounter issues:

1. Check this guide thoroughly
2. Review error messages carefully
3. Search Flutter/Firebase documentation
4. Check GitHub Issues
5. Ask in Flutter community forums

## 📄 License

MIT License - Free to use and modify!

---

**May the shadows guide your development journey! 🌙✨**