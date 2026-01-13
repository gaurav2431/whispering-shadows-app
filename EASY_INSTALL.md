# 📱 Easy Installation Guide (No Coding Required!)

This guide is for **non-developers** who just want to use the app.

---

## 🎯 **Method 1: Use Codemagic (Easiest - 10 minutes)**

Codemagic will build the app for you automatically!

### **Step 1: Fork the Repository**

1. Go to: https://github.com/gaurav2431/whispering-shadows-app
2. Click **"Fork"** button (top right)
3. This creates your own copy

### **Step 2: Add Your API Key**

1. In YOUR forked repository, click on `lib/services/openai_service.dart`
2. Click the **pencil icon** (Edit)
3. Find line 11: `static const String _apiKey = 'YOUR_OPENAI_API_KEY_HERE';`
4. Replace `YOUR_OPENAI_API_KEY_HERE` with your actual key
5. Click **"Commit changes"**

### **Step 3: Build with Codemagic**

1. Go to: https://codemagic.io
2. Sign up with GitHub (free)
3. Click **"Add application"**
4. Select your forked repository
5. Choose **"Flutter App"**
6. Click **"Start your first build"**
7. Wait 10-15 minutes
8. Download the APK!

---

## 🎯 **Method 2: Use GitHub Codespaces (Free)**

Build directly in your browser!

### **Step 1: Open in Codespaces**

1. Go to: https://github.com/gaurav2431/whispering-shadows-app
2. Click green **"Code"** button
3. Click **"Codespaces"** tab
4. Click **"Create codespace on main"**
5. Wait for it to load (2-3 minutes)

### **Step 2: Add Your API Key**

1. In the file explorer (left side), navigate to:
   `lib/services/openai_service.dart`
2. Click to open it
3. Find line 11 and replace with your API key
4. Press `Ctrl+S` to save

### **Step 3: Build the APK**

In the terminal at the bottom, run:

```bash
# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Get dependencies
flutter pub get

# Build APK
flutter build apk --release
```

### **Step 4: Download**

1. The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`
2. Right-click → Download
3. Transfer to your phone and install!

---

## 🎯 **Method 3: Use Replit (Simplest)**

### **Step 1: Import to Replit**

1. Go to: https://replit.com
2. Sign up (free)
3. Click **"Create Repl"**
4. Choose **"Import from GitHub"**
5. Paste: `https://github.com/gaurav2431/whispering-shadows-app`

### **Step 2: Add API Key**

1. Open `lib/services/openai_service.dart`
2. Replace the API key on line 11
3. The file auto-saves

### **Step 3: Build**

In the Shell/Console, run:
```bash
flutter pub get
flutter build apk --release
```

Download the APK from `build/app/outputs/flutter-apk/app-release.apk`

---

## 🎯 **Method 4: Ask a Developer Friend**

The **absolute easiest** way:

1. Send this repository link to a developer friend: 
   https://github.com/gaurav2431/whispering-shadows-app
2. Give them your OpenAI API key
3. Ask them to build an APK for you
4. They run: `flutter build apk --release`
5. They send you the APK file
6. Install on your phone!

---

## 📱 **Installing the APK on Android**

Once you have the APK file:

### **Step 1: Transfer to Phone**

- Email it to yourself
- Use Google Drive
- Use USB cable
- Use AirDrop (if available)

### **Step 2: Enable Unknown Sources**

1. Go to **Settings**
2. **Security** or **Privacy**
3. Enable **"Install from Unknown Sources"** or **"Install Unknown Apps"**
4. Allow for your browser/file manager

### **Step 3: Install**

1. Open the APK file on your phone
2. Tap **"Install"**
3. Wait for installation
4. Tap **"Open"**

---

## ⚠️ **Important Notes**

### **Firebase Setup Required**

The app also needs Firebase. Without it:
- ✅ You can draw cards
- ✅ You can see AI interpretations
- ❌ History won't save
- ❌ Ghost chat won't save

**To add Firebase:**
1. Create project at https://console.firebase.google.com
2. Download `google-services.json`
3. Place in `android/app/` before building

### **API Key Security**

⚠️ Your API key will be in the app. For personal use this is OK, but:
- Don't share the APK publicly
- Monitor your OpenAI usage
- Set spending limits in OpenAI dashboard

---

## 🆘 **Still Need Help?**

If all of this seems too complicated, you have two options:

### **Option A: Wait for Official Release**

I can prepare this app for official release on Google Play Store, but that requires:
- Developer account ($25 one-time fee)
- Proper Firebase setup
- Backend API proxy for security
- Testing and compliance

### **Option B: Simplified Web Version**

I can create a **web version** that runs in your browser:
- No installation needed
- Works on any device
- Just visit a URL
- Same features

Would you prefer the web version? Let me know!

---

## 💡 **Recommended: Use Codemagic**

For most people, **Method 1 (Codemagic)** is the easiest:
- ✅ No coding required
- ✅ Automatic building
- ✅ Free for open source
- ✅ Download APK directly

**Try it first!** 🚀