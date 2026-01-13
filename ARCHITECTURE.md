# 🏗️ Whispering Shadows - Architecture & Technical Documentation

## 📐 System Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Flutter Mobile App                    │
├─────────────────────────────────────────────────────────┤
│                                                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Screens    │  │   Widgets    │  │   Models     │  │
│  │              │  │              │  │              │  │
│  │ • Home       │  │ • TarotCard  │  │ • TarotCard  │  │
│  │ • Tarot      │  │ • ChatBubble │  │ • Reading    │  │
│  │ • GhostChat  │  │              │  │              │  │
│  │ • History    │  │              │  │              │  │
│  └──────┬───────┘  └──────────────┘  └──────────────┘  │
│         │                                                │
│  ┌──────▼──────────────────────────────────────────┐   │
│  │              Services Layer                      │   │
│  │                                                   │   │
│  │  ┌──────────────┐  ┌──────────────┐            │   │
│  │  │ TarotService │  │ OpenAIService│            │   │
│  │  │              │  │              │            │   │
│  │  │ • 78 Cards   │  │ • GPT-4 API  │            │   │
│  │  │ • Shuffle    │  │ • Tarot AI   │            │   │
│  │  │ • Draw       │  │ • Ghost AI   │            │   │
│  │  └──────────────┘  └──────────────┘            │   │
│  │                                                   │   │
│  │  ┌──────────────────────────────────┐           │   │
│  │  │      FirebaseService              │           │   │
│  │  │                                    │           │   │
│  │  │  • Save/Load Readings              │           │   │
│  │  │  • Chat History                    │           │   │
│  │  │  • User Profiles                   │           │   │
│  │  └──────────────────────────────────┘           │   │
│  └───────────────────────────────────────────────────┘   │
│                                                           │
└─────────────────────────────────────────────────────────┘
                          │
                          │
        ┌─────────────────┴─────────────────┐
        │                                     │
        ▼                                     ▼
┌───────────────┐                    ┌───────────────┐
│   Firebase    │                    │   OpenAI API  │
│   Firestore   │                    │               │
│               │                    │   GPT-4 /     │
│ • readings/   │                    │   GPT-3.5     │
│ • users/      │                    │               │
│ • chat_history│                    │               │
└───────────────┘                    └───────────────┘
```

## 🎯 Core Components

### 1. Models Layer

**TarotCard Model**
- Represents individual tarot cards
- Properties: name, meanings, suit, number, orientation
- Methods: JSON serialization, orientation toggle

**Reading Model**
- Represents complete reading sessions
- Contains: cards, interpretations, timestamp, user question
- Persisted to Firebase

### 2. Services Layer

**TarotService**
- Singleton pattern for deck management
- 78-card deck initialization (22 Major + 56 Minor Arcana)
- Fisher-Yates shuffle algorithm
- Random card reversal (50% chance)

**OpenAIService**
- GPT-4 API integration
- Two AI personalities:
  - **Tarot Reader**: Mystical, poetic interpretations
  - **Ghost**: Cryptic, spooky conversational agent
- Temperature: 0.8 for creative responses
- Max tokens: 300 per response

**FirebaseService**
- Firestore database operations
- Collections:
  - `readings/`: Tarot reading sessions
  - `users/{userId}/chat_history/`: Ghost chat messages
  - `users/{userId}/`: User profiles
- CRUD operations with error handling

### 3. UI Layer

**Screens**
- `HomeScreen`: Navigation hub with gradient background
- `TarotScreen`: Card drawing and interpretation display
- `GhostChatScreen`: Real-time chat with AI ghost
- `HistoryScreen`: Past readings with detail view

**Widgets**
- `TarotCardWidget`: Reusable card display with icons
- `ChatBubble`: Message bubbles with user/ghost styling

## 🎨 Design System

### Color Palette

```dart
Primary: #6A0DAD (Deep Purple)
Secondary: #9D4EDD (Light Purple)
Background: #0D0221 (Very Dark Purple)
Surface: #1A0B2E (Dark Purple)
```

### Typography

- **Headers**: Cinzel (mystical serif font)
- **Body**: Crimson Text (readable serif)
- **Style**: Poetic, atmospheric, mysterious

### Theme

- Dark mode only
- Gradient backgrounds
- Glowing card effects
- Mystical purple accents

## 🔄 Data Flow

### Tarot Reading Flow

```
User Input (Question)
    ↓
TarotService.drawThreeCardSpread()
    ↓
Display Cards (Past, Present, Future)
    ↓
OpenAIService.generateReadingInterpretations()
    ↓
Display AI Interpretations
    ↓
FirebaseService.saveReading()
    ↓
Persist to Firestore
```

### Ghost Chat Flow

```
User Message
    ↓
Display in Chat UI
    ↓
FirebaseService.saveChatMessage()
    ↓
OpenAIService.sendGhostMessage()
    ↓
Display Ghost Response
    ↓
FirebaseService.saveChatMessage()
    ↓
Persist to Firestore
```

## 🔐 Security Architecture

### Current (MVP)

- API key in source code (for development only)
- Test mode Firestore rules
- No authentication

### Production (Recommended)

```
┌─────────────┐
│ Flutter App │
└──────┬──────┘
       │
       │ HTTPS
       ▼
┌─────────────┐
│   Backend   │
│   Proxy     │  ← API Key stored here
│             │
│ Node.js/    │
│ Python/     │
│ Cloud Fn    │
└──────┬──────┘
       │
       │ API Key
       ▼
┌─────────────┐
│  OpenAI API │
└─────────────┘
```

**Security Layers:**
1. Firebase Authentication
2. Firestore Security Rules
3. Backend API proxy
4. Environment variables
5. Rate limiting

## 📊 Database Schema

### Firestore Structure

```
firestore/
├── readings/
│   └── {readingId}/
│       ├── id: string
│       ├── timestamp: timestamp
│       ├── userId: string
│       ├── question: string?
│       ├── cards: array
│       │   └── {
│       │       name: string,
│       │       uprightMeaning: string,
│       │       reversedMeaning: string,
│       │       suit: string?,
│       │       number: int,
│       │       isReversed: bool
│       │   }
│       └── interpretations: map
│           └── {
│               "Past": "AI interpretation...",
│               "Present": "AI interpretation...",
│               "Future": "AI interpretation..."
│           }
│
└── users/
    └── {userId}/
        ├── profile: map
        └── chat_history/
            └── {messageId}/
                ├── message: string
                ├── isUser: bool
                └── timestamp: timestamp
```

## 🧪 Testing Strategy

### Unit Tests

```dart
test('Deck initialization creates 78 cards', () {
  final service = TarotService();
  service.initializeDeck();
  expect(service._deck.length, 78);
});

test('Three card spread returns 3 cards', () {
  final service = TarotService();
  final cards = service.drawThreeCardSpread();
  expect(cards.length, 3);
});
```

### Widget Tests

```dart
testWidgets('TarotCardWidget displays card name', (tester) async {
  final card = TarotCard(
    name: 'The Fool',
    number: 0,
    uprightMeaning: 'New beginnings',
    reversedMeaning: 'Recklessness',
  );
  
  await tester.pumpWidget(
    MaterialApp(
      home: TarotCardWidget(card: card),
    ),
  );
  
  expect(find.text('The Fool'), findsOneWidget);
});
```

### Integration Tests

```dart
testWidgets('Complete tarot reading flow', (tester) async {
  // 1. Navigate to tarot screen
  // 2. Enter question
  // 3. Draw cards
  // 4. Verify cards displayed
  // 5. Verify interpretations generated
  // 6. Verify saved to Firebase
});
```

## 🚀 Performance Optimization

### Current Optimizations

1. **Singleton Pattern**: TarotService reuses deck
2. **Lazy Loading**: Deck initialized on first use
3. **Pagination**: History limited to 20 readings
4. **Async Operations**: All API calls non-blocking
5. **State Management**: Minimal rebuilds with setState

### Future Optimizations

1. **Caching**: Cache AI responses for identical queries
2. **Image Optimization**: Compress tarot card images
3. **Lazy Loading**: Paginate chat history
4. **Background Processing**: Pre-generate daily cards
5. **CDN**: Serve static assets from CDN

## 📈 Scalability Considerations

### Current Limits

- OpenAI API rate limits
- Firebase free tier limits
- Single-region deployment

### Scaling Strategy

```
Phase 1 (MVP): 
- 1,000 users
- Firebase free tier
- OpenAI pay-as-you-go

Phase 2 (Growth):
- 10,000 users
- Firebase Blaze plan
- Backend caching layer
- Multi-region deployment

Phase 3 (Scale):
- 100,000+ users
- Dedicated backend servers
- Load balancing
- CDN for assets
- Database sharding
```

## 🔮 Future Architecture

### AR Ghost Portals

```dart
// AR Layer
ar_flutter_plugin
    ↓
ARCore/ARKit
    ↓
3D Ghost Models
    ↓
Spatial Audio
```

### Voice Interactions

```dart
// Voice Pipeline
speech_to_text
    ↓
OpenAI Whisper API
    ↓
GPT-4 Processing
    ↓
flutter_tts
    ↓
Spooky Voice Output
```

### Real-time Features

```dart
// WebSocket Layer
Firebase Realtime Database
    ↓
Live Ghost Presence
    ↓
Multi-user Séances
    ↓
Shared Readings
```

## 📚 Technology Stack

### Frontend
- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider
- **UI**: Material Design + Custom Theme

### Backend
- **Database**: Firebase Firestore
- **Authentication**: Firebase Auth (planned)
- **Storage**: Firebase Storage (for images)
- **Functions**: Cloud Functions (planned)

### AI/ML
- **LLM**: OpenAI GPT-4 / GPT-3.5-turbo
- **API**: REST (OpenAI Chat Completions)
- **Future**: Whisper (voice), DALL-E (images)

### DevOps
- **Version Control**: Git/GitHub
- **CI/CD**: GitHub Actions (planned)
- **Monitoring**: Firebase Analytics
- **Crash Reporting**: Firebase Crashlytics (planned)

## 🎯 Development Roadmap

### Phase 1: MVP ✅
- [x] 78-card tarot deck
- [x] 3-card spread
- [x] AI interpretations
- [x] Ghost chat
- [x] Reading history
- [x] Firebase integration

### Phase 2: Enhancement
- [ ] Firebase Authentication
- [ ] User profiles
- [ ] Custom spreads (Celtic Cross, etc.)
- [ ] Daily card notifications
- [ ] Sound effects
- [ ] Haptic feedback

### Phase 3: Advanced
- [ ] AR ghost portals
- [ ] Voice interactions
- [ ] Social features
- [ ] Premium themes
- [ ] Multi-language support
- [ ] Offline mode

### Phase 4: Scale
- [ ] Backend optimization
- [ ] CDN integration
- [ ] Advanced analytics
- [ ] A/B testing
- [ ] Monetization

---

**Built with mystical precision and spooky attention to detail! 🌙✨**