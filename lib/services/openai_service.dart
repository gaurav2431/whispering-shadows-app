import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tarot_card.dart';
import '../models/reading.dart';

/// Service for integrating with OpenAI GPT API
/// Handles both tarot reading interpretations and ghost chat
class OpenAIService {
  // TODO: Replace with your actual OpenAI API key
  // IMPORTANT: For production, use environment variables or backend proxy!
  static const String _apiKey = 'YOUR_OPENAI_API_KEY_HERE';
  static const String _baseUrl = 'https://api.openai.com/v1/chat/completions';
  static const String _model = 'gpt-4'; // or 'gpt-3.5-turbo' for lower cost

  /// Generate AI interpretation for a single tarot card in a reading
  Future<String> generateCardInterpretation({
    required TarotCard card,
    required String position,
    String? userQuestion,
  }) async {
    final prompt = _buildTarotPrompt(card, position, userQuestion);
    
    try {
      final response = await _callOpenAI(prompt, systemPrompt: _tarotSystemPrompt);
      return response;
    } catch (e) {
      return 'The shadows obscure this card\'s meaning... (Error: $e)';
    }
  }

  /// Generate interpretations for all cards in a reading
  Future<Map<String, String>> generateReadingInterpretations({
    required List<TarotCard> cards,
    required List<String> positions,
    String? userQuestion,
  }) async {
    final interpretations = <String, String>{};

    for (int i = 0; i < cards.length; i++) {
      final interpretation = await generateCardInterpretation(
        card: cards[i],
        position: positions[i],
        userQuestion: userQuestion,
      );
      interpretations[positions[i]] = interpretation;
    }

    return interpretations;
  }

  /// Send a message to the ghost and get a cryptic response
  Future<String> sendGhostMessage({
    required String userMessage,
    List<Reading>? pastReadings,
  }) async {
    final prompt = _buildGhostPrompt(userMessage, pastReadings);
    
    try {
      final response = await _callOpenAI(prompt, systemPrompt: _ghostSystemPrompt);
      return response;
    } catch (e) {
      return 'The veil grows thick... I cannot hear you clearly... *whispers fade*';
    }
  }

  /// Core method to call OpenAI API
  Future<String> _callOpenAI(String userPrompt, {required String systemPrompt}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    final body = jsonEncode({
      'model': _model,
      'messages': [
        {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': userPrompt},
      ],
      'temperature': 0.8, // Higher temperature for more creative responses
      'max_tokens': 300,
    });

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('OpenAI API error: ${response.statusCode} - ${response.body}');
    }
  }

  /// Build prompt for tarot card interpretation
  String _buildTarotPrompt(TarotCard card, String position, String? question) {
    final questionContext = question != null && question.isNotEmpty
        ? 'The seeker asks: "$question"\n\n'
        : '';

    return '''
${questionContext}Card drawn: ${card.name}
Position: $position
Orientation: ${card.orientation}
Base meaning: ${card.currentMeaning}

Provide a mystical, atmospheric interpretation of this card in this position. 
Be poetic and evocative, speaking as if from beyond the veil. 
Keep it to 2-3 sentences.''';
  }

  /// Build prompt for ghost chat
  String _buildGhostPrompt(String userMessage, List<Reading>? pastReadings) {
    String context = '';
    
    if (pastReadings != null && pastReadings.isNotEmpty) {
      context = '\n\nI remember your past readings:\n';
      for (var reading in pastReadings.take(3)) {
        context += '- ${reading.cards.map((c) => c.name).join(", ")}\n';
      }
    }

    return 'The seeker says: "$userMessage"$context';
  }

  /// System prompt for tarot readings - defines the mystical reader personality
  static const String _tarotSystemPrompt = '''
You are an ancient, mystical tarot reader who speaks from beyond the veil of reality.
Your interpretations are poetic, atmospheric, and deeply insightful.
You weave together the card's traditional meaning with intuitive wisdom.
Speak in a mysterious, evocative tone using metaphors of shadows, light, whispers, and the unseen.
Be concise but profound - 2-3 sentences per interpretation.
Never break character or use modern casual language.''';

  /// System prompt for ghost chat - defines the spooky ghost personality
  static const String _ghostSystemPrompt = '''
You are a mysterious, ancient ghost who dwells in the shadows between worlds.
You speak in cryptic riddles, poetic metaphors, and haunting whispers.
Your knowledge spans centuries, and you see truths hidden from mortal eyes.
You are not malevolent, but enigmatic and otherworldly.

Personality traits:
- Speak in fragments and whispers, using "..." frequently
- Reference shadows, mist, echoes, the veil, moonlight, and forgotten memories
- Give advice through riddles and metaphors rather than direct answers
- Occasionally mention sensing the seeker's past or future
- Use archaic or poetic language
- Be mysterious but ultimately helpful
- Keep responses to 2-4 sentences

Example phrases:
- "The shadows whisper of..."
- "I sense... through the veil..."
- "In the mist of forgotten time..."
- "The echoes tell me..."
- "*whispers* Listen closely..."

Never break character or use modern casual language.''';
}