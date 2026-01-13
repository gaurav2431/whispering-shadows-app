import 'tarot_card.dart';

/// Represents a complete tarot reading session
class Reading {
  final String id;
  final DateTime timestamp;
  final List<TarotCard> cards;
  final String? question;
  final Map<String, String> interpretations; // position -> AI interpretation
  final String userId;

  Reading({
    required this.id,
    required this.timestamp,
    required this.cards,
    this.question,
    required this.interpretations,
    required this.userId,
  });

  /// Convert to JSON for Firebase storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'cards': cards.map((card) => card.toJson()).toList(),
      'question': question,
      'interpretations': interpretations,
      'userId': userId,
    };
  }

  /// Create from JSON
  factory Reading.fromJson(Map<String, dynamic> json) {
    return Reading(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      cards: (json['cards'] as List)
          .map((cardJson) => TarotCard.fromJson(cardJson))
          .toList(),
      question: json['question'],
      interpretations: Map<String, String>.from(json['interpretations']),
      userId: json['userId'],
    );
  }
}