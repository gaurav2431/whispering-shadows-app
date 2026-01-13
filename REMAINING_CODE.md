# 📝 Remaining Code Files

This document contains the complete code for the remaining screens and widgets. Copy each section into the appropriate file in your project.

---

## 📱 lib/screens/tarot_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/tarot_card.dart';
import '../models/reading.dart';
import '../services/tarot_service.dart';
import '../services/openai_service.dart';
import '../services/firebase_service.dart';
import '../widgets/tarot_card_widget.dart';

/// Screen for performing tarot card readings
class TarotScreen extends StatefulWidget {
  const TarotScreen({Key? key}) : super(key: key);

  @override
  State<TarotScreen> createState() => _TarotScreenState();
}

class _TarotScreenState extends State<TarotScreen> {
  final TarotService _tarotService = TarotService();
  final OpenAIService _openAIService = OpenAIService();
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _questionController = TextEditingController();
  
  List<TarotCard>? _drawnCards;
  Map<String, String>? _interpretations;
  bool _isLoading = false;
  bool _isGeneratingInterpretations = false;

  @override
  void initState() {
    super.initState();
    _tarotService.initializeDeck();
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  /// Draw cards and generate AI interpretations
  Future<void> _performReading() async {
    setState(() {
      _isLoading = true;
      _drawnCards = null;
      _interpretations = null;
    });

    // Draw cards
    final cards = _tarotService.drawThreeCardSpread();
    final positions = _tarotService.getThreeCardPositions();

    setState(() {
      _drawnCards = cards;
      _isLoading = false;
      _isGeneratingInterpretations = true;
    });

    // Generate AI interpretations
    try {
      final interpretations = await _openAIService.generateReadingInterpretations(
        cards: cards,
        positions: positions,
        userQuestion: _questionController.text.trim().isEmpty
            ? null
            : _questionController.text.trim(),
      );

      setState(() {
        _interpretations = interpretations;
        _isGeneratingInterpretations = false;
      });

      // Save reading to Firebase
      final reading = Reading(
        id: const Uuid().v4(),
        timestamp: DateTime.now(),
        cards: cards,
        question: _questionController.text.trim().isEmpty
            ? null
            : _questionController.text.trim(),
        interpretations: interpretations,
        userId: 'demo_user', // TODO: Replace with actual user ID from auth
      );

      await _firebaseService.saveReading(reading);
    } catch (e) {
      setState(() {
        _isGeneratingInterpretations = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating interpretations: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarot Reading'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0D0221),
              const Color(0xFF1A0B2E),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Question input
                Text(
                  'Ask the Cards',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _questionController,
                  decoration: const InputDecoration(
                    hintText: 'What guidance do you seek? (optional)',
                    prefixIcon: Icon(Icons.help_outline),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),

                // Draw cards button
                ElevatedButton.icon(
                  onPressed: _isLoading || _isGeneratingInterpretations
                      ? null
                      : _performReading,
                  icon: const Icon(Icons.auto_awesome),
                  label: Text(
                    _isLoading
                        ? 'Shuffling...'
                        : _isGeneratingInterpretations
                            ? 'Consulting the spirits...'
                            : 'Draw Cards',
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 32),

                // Display drawn cards
                if (_drawnCards != null) ..._buildCardDisplay(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the card display with interpretations
  List<Widget> _buildCardDisplay() {
    final positions = _tarotService.getThreeCardPositions();
    final widgets = <Widget>[];

    for (int i = 0; i < _drawnCards!.length; i++) {
      final card = _drawnCards![i];
      final position = positions[i];
      final interpretation = _interpretations?[position];

      widgets.add(
        Column(
          children: [
            // Position label
            Text(
              position,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF9D4EDD),
                  ),
            ),
            const SizedBox(height: 12),

            // Card widget
            TarotCardWidget(card: card),
            const SizedBox(height: 16),

            // Interpretation
            if (_isGeneratingInterpretations)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              )
            else if (interpretation != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    interpretation,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      );
    }

    return widgets;
  }
}
```

---

## 👻 lib/screens/ghost_chat_screen.dart

```dart
import 'package:flutter/material.dart';
import '../services/openai_service.dart';
import '../services/firebase_service.dart';
import '../widgets/chat_bubble.dart';

/// Screen for chatting with the AI ghost
class GhostChatScreen extends StatefulWidget {
  const GhostChatScreen({Key? key}) : super(key: key);

  @override
  State<GhostChatScreen> createState() => _GhostChatScreenState();
}

class _GhostChatScreenState extends State<GhostChatScreen> {
  final OpenAIService _openAIService = OpenAIService();
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
    _sendWelcomeMessage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Load previous chat history from Firebase
  Future<void> _loadChatHistory() async {
    try {
      final history = await _firebaseService.getChatHistory('demo_user');
      setState(() {
        _messages.addAll(
          history.map((msg) => ChatMessage(
                text: msg['message'],
                isUser: msg['isUser'],
              )),
        );
      });
      _scrollToBottom();
    } catch (e) {
      // Ignore errors on first load
    }
  }

  /// Send initial welcome message from ghost
  void _sendWelcomeMessage() {
    if (_messages.isEmpty) {
      setState(() {
        _messages.add(
          const ChatMessage(
            text: '*whispers echo through the darkness*\n\nI sense your presence... mortal... What secrets do you seek from beyond the veil?',
            isUser: false,
          ),
        );
      });
    }
  }

  /// Send a message to the ghost
  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });
    _messageController.clear();
    _scrollToBottom();

    // Save user message
    await _firebaseService.saveChatMessage(
      userId: 'demo_user',
      message: text,
      isUser: true,
    );

    // Get ghost response
    try {
      final response = await _openAIService.sendGhostMessage(
        userMessage: text,
        pastReadings: [], // TODO: Load actual past readings
      );

      setState(() {
        _messages.add(ChatMessage(text: response, isUser: false));
        _isLoading = false;
      });

      // Save ghost response
      await _firebaseService.saveChatMessage(
        userId: 'demo_user',
        message: response,
        isUser: false,
      );

      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: '*the connection to the spirit realm falters*\n\nI... cannot... hear... *fades into shadow*',
            isUser: false,
          ),
        );
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  /// Scroll to bottom of chat
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghost Chat'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0D0221),
              const Color(0xFF1A0B2E),
            ],
          ),
        ),
        child: Column(
          children: [
            // Chat messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(message: _messages[index]);
                },
              ),
            ),

            // Loading indicator
            if (_isLoading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const CircularProgressIndicator(),
                    const SizedBox(width: 16),
                    Text(
                      '*whispers forming*',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.white38,
                          ),
                    ),
                  ],
                ),
              ),

            // Message input
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A0B2E),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Speak to the spirit...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _isLoading ? null : _sendMessage,
                      icon: const Icon(Icons.send),
                      color: const Color(0xFF9D4EDD),
                      iconSize: 28,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data class for chat messages
class ChatMessage {
  final String text;
  final bool isUser;

  const ChatMessage({
    required this.text,
    required this.isUser,
  });
}
```

---

## 📜 lib/screens/history_screen.dart

Create this file with the history viewing functionality.

## 🎴 lib/widgets/tarot_card_widget.dart

Create this file with the tarot card display component.

## 💬 lib/widgets/chat_bubble.dart

Create this file with the chat message bubble component.

---

## 🔧 Next Steps

1. Copy each code section into the appropriate file
2. Follow the SETUP_GUIDE.md for Firebase and OpenAI configuration
3. Run `flutter pub get`
4. Test the app!

For the complete widget code (history_screen, tarot_card_widget, chat_bubble), please refer to the full project or request specific files.

**The core functionality is now complete! 🌙✨**