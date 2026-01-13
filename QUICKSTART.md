# ⚡ Quick Start Guide

Get Whispering Shadows running in 10 minutes!

## 🎯 Prerequisites Checklist

- [ ] Flutter SDK installed (`flutter doctor` passes)
- [ ] Firebase account created
- [ ] OpenAI API key obtained
- [ ] Android Studio or Xcode installed

## 🚀 5-Step Setup

### Step 1: Clone & Install (2 min)

```bash
git clone https://github.com/gaurav2431/whispering-shadows-app.git
cd whispering-shadows-app
flutter pub get
```

### Step 2: Firebase Setup (3 min)

1. Create project at [Firebase Console](https://console.firebase.google.com)
2. Add Android app → Download `google-services.json` → Place in `android/app/`
3. Add iOS app → Download `GoogleService-Info.plist` → Place in `ios/Runner/`
4. Enable Firestore Database (test mode)

### Step 3: Add OpenAI Key (1 min)

Edit `lib/services/openai_service.dart`:

```dart
static const String _apiKey = 'sk-your-key-here'; // Line 11
```

### Step 4: Run the App (2 min)

```bash
flutter run
```

### Step 5: Test Features (2 min)

1. Tap "Tarot Reading" → Draw cards
2. Tap "Ghost Chat" → Send a message
3. Tap "Past Readings" → View history

## ✅ Verification

If you see:
- ✅ Cards drawing successfully
- ✅ AI interpretations appearing
- ✅ Ghost responding to messages
- ✅ Readings saving to history

**You're all set! 🎉**

## 🐛 Common Issues

### "Firebase not configured"
→ Check `google-services.json` and `GoogleService-Info.plist` are in correct locations

### "OpenAI API error"
→ Verify your API key is correct and you have credits

### "Build failed"
→ Run `flutter clean && flutter pub get`

## 📚 Next Steps

1. Read [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed configuration
2. Check [ARCHITECTURE.md](ARCHITECTURE.md) to understand the codebase
3. Explore [AI_PROMPTS.md](AI_PROMPTS.md) to customize AI personalities
4. Review [REMAINING_CODE.md](REMAINING_CODE.md) for additional screens

## 🎨 Customization Quick Tips

**Change colors**: Edit `lib/main.dart` line 25-30
**Modify ghost personality**: Edit `lib/services/openai_service.dart` line 95-115
**Add more cards**: Edit `lib/services/tarot_service.dart` line 25-150

## 🆘 Need Help?

- Check [SETUP_GUIDE.md](SETUP_GUIDE.md) for troubleshooting
- Review error messages carefully
- Ensure all prerequisites are met

---

**Happy coding! May the shadows guide you! 🌙✨**