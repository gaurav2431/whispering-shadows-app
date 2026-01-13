# 🌙 Whispering Shadows - AI Ghost & Tarot App

An interactive AI-powered ghost and tarot reading mobile app built with Flutter.

## ✨ Features

- 🎴 **Tarot Card Readings**: Shuffle and draw 3-card spreads with upright/reversed orientations
- 🤖 **AI-Powered Interpretations**: Dynamic, mystical readings generated using OpenAI GPT
- 👻 **Ghost Chat**: Interact with a cryptic, spooky AI ghost companion
- 💾 **Reading History**: Track past readings for personalized ghost memory
- 🎨 **Beautiful Dark UI**: Mystical purple and dark theme
- 🔮 **Future Ready**: Prepared for AR ghost portals and visual effects

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Dart SDK
- Firebase account
- OpenAI API key

### Installation

1. **Clone this repository**
   ```bash
   git clone https://github.com/gaurav2431/whispering-shadows-app.git
   cd whispering-shadows-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project at https://console.firebase.google.com
   - Add your Android/iOS apps to the Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`
   - Enable Firestore Database in Firebase Console

4. **Add your OpenAI API Key**
   - Open `lib/services/openai_service.dart`
   - Replace `'YOUR_OPENAI_API_KEY_HERE'` with your actual API key
   - **IMPORTANT**: For production, use environment variables or secure storage!

5. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── tarot_card.dart      # Tarot card data model
│   └── reading.dart         # Reading session model
├── services/
│   ├── tarot_service.dart   # Card shuffle & draw logic (78 cards)
│   ├── openai_service.dart  # AI integration for readings & chat
│   └── firebase_service.dart # Database operations
├── screens/
│   ├── home_screen.dart     # Main navigation
│   ├── tarot_screen.dart    # Tarot card reading interface
│   ├── ghost_chat_screen.dart # Ghost chat interface
│   └── history_screen.dart  # Past readings history
└── widgets/
    ├── tarot_card_widget.dart # Card display component
    └── chat_bubble.dart       # Chat message bubble
```

## 🎴 Tarot Card Database

The app includes all 78 tarot cards:
- 22 Major Arcana cards (The Fool to The World)
- 56 Minor Arcana cards (Wands, Cups, Swords, Pentacles)

Each card has:
- Name
- Upright meaning
- Reversed meaning
- Suit (for Minor Arcana)

## 🤖 AI Integration

### Tarot Readings
The AI generates mystical, personalized interpretations based on:
- Card drawn
- Position in spread (Past, Present, Future)
- Orientation (Upright/Reversed)
- User's question (optional)

### Ghost Chat
The ghost companion has a mysterious, cryptic personality:
- Speaks in riddles and metaphors
- References shadows, whispers, and the veil
- Remembers past readings for context
- Provides spooky, atmospheric responses

## 🔮 Future Enhancements

### AR Ghost Portals (Planned)
```dart
// Using AR Core/AR Kit
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';

// Create AR session for ghost portal visualization
// Display floating tarot cards in AR space
// Interactive ghost apparitions
```

### Additional Features
- [ ] Daily card draw notifications
- [ ] Moon phase integration
- [ ] Custom card spreads (Celtic Cross, etc.)
- [ ] Voice-based ghost interactions
- [ ] Spooky sound effects and haptic feedback
- [ ] Social sharing of readings
- [ ] Premium mystical themes

## 🔐 Security Notes

**IMPORTANT**: This starter code includes the API key directly for MVP testing. For production:

1. **Use Environment Variables**
   ```dart
   import 'package:flutter_dotenv/flutter_dotenv.dart';
   final apiKey = dotenv.env['OPENAI_API_KEY'];
   ```

2. **Use Backend Proxy**
   - Create a backend service to handle OpenAI calls
   - Never expose API keys in client code

3. **Implement Authentication**
   - Use Firebase Auth for user management
   - Secure Firestore with proper rules

## 📱 Running on Devices

### Android
```bash
flutter run -d android
```

### iOS
```bash
flutter run -d ios
```

### Web (for testing UI)
```bash
flutter run -d chrome
```

## 🎨 Customization

### Change Theme Colors
Edit `lib/main.dart`:
```dart
primaryColor: Color(0xFF6A0DAD), // Deep purple
accentColor: Color(0xFF9D4EDD), // Light purple
```

### Modify Ghost Personality
Edit `lib/services/openai_service.dart` - update the system prompt in `sendGhostMessage()`

### Add More Cards
Edit `lib/services/tarot_service.dart` - add to `_initializeDeck()`

## 📄 License

MIT License - feel free to use this for your projects!

## 🙏 Credits

- Tarot card meanings from traditional Rider-Waite interpretations
- AI powered by OpenAI GPT
- Database by Firebase

---

**May the shadows whisper wisdom to you... 🌙👻**