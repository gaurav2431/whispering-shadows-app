/// Represents a single tarot card with its meanings and properties
class TarotCard {
  final String name;
  final String uprightMeaning;
  final String reversedMeaning;
  final String? suit; // null for Major Arcana
  final int number;
  final bool isReversed;

  TarotCard({
    required this.name,
    required this.uprightMeaning,
    required this.reversedMeaning,
    this.suit,
    required this.number,
    this.isReversed = false,
  });

  /// Get the current meaning based on orientation
  String get currentMeaning => isReversed ? reversedMeaning : uprightMeaning;

  /// Get orientation as string
  String get orientation => isReversed ? 'Reversed' : 'Upright';

  /// Check if this is a Major Arcana card
  bool get isMajorArcana => suit == null;

  /// Create a copy with reversed orientation
  TarotCard copyWithReversed(bool reversed) {
    return TarotCard(
      name: name,
      uprightMeaning: uprightMeaning,
      reversedMeaning: reversedMeaning,
      suit: suit,
      number: number,
      isReversed: reversed,
    );
  }

  /// Convert to JSON for Firebase storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uprightMeaning': uprightMeaning,
      'reversedMeaning': reversedMeaning,
      'suit': suit,
      'number': number,
      'isReversed': isReversed,
    };
  }

  /// Create from JSON
  factory TarotCard.fromJson(Map<String, dynamic> json) {
    return TarotCard(
      name: json['name'],
      uprightMeaning: json['uprightMeaning'],
      reversedMeaning: json['reversedMeaning'],
      suit: json['suit'],
      number: json['number'],
      isReversed: json['isReversed'] ?? false,
    );
  }
}