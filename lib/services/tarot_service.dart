import 'dart:math';
import '../models/tarot_card.dart';

/// Service for managing tarot card deck and drawing logic
class TarotService {
  static final TarotService _instance = TarotService._internal();
  factory TarotService() => _instance;
  TarotService._internal();

  final List<TarotCard> _deck = [];
  final Random _random = Random();

  /// Initialize the complete 78-card tarot deck
  void initializeDeck() {
    if (_deck.isNotEmpty) return; // Already initialized

    _deck.addAll(_createMajorArcana());
    _deck.addAll(_createMinorArcana());
  }

  /// Create the 22 Major Arcana cards
  List<TarotCard> _createMajorArcana() {
    return [
      TarotCard(
        name: 'The Fool',
        number: 0,
        uprightMeaning: 'New beginnings, innocence, spontaneity, free spirit',
        reversedMeaning: 'Recklessness, taken advantage of, inconsideration',
      ),
      TarotCard(
        name: 'The Magician',
        number: 1,
        uprightMeaning: 'Manifestation, resourcefulness, power, inspired action',
        reversedMeaning: 'Manipulation, poor planning, untapped talents',
      ),
      TarotCard(
        name: 'The High Priestess',
        number: 2,
        uprightMeaning: 'Intuition, sacred knowledge, divine feminine, subconscious',
        reversedMeaning: 'Secrets, disconnected from intuition, withdrawal',
      ),
      TarotCard(
        name: 'The Empress',
        number: 3,
        uprightMeaning: 'Femininity, beauty, nature, nurturing, abundance',
        reversedMeaning: 'Creative block, dependence on others, emptiness',
      ),
      TarotCard(
        name: 'The Emperor',
        number: 4,
        uprightMeaning: 'Authority, establishment, structure, father figure',
        reversedMeaning: 'Domination, excessive control, lack of discipline',
      ),
      TarotCard(
        name: 'The Hierophant',
        number: 5,
        uprightMeaning: 'Spiritual wisdom, religious beliefs, conformity, tradition',
        reversedMeaning: 'Personal beliefs, freedom, challenging the status quo',
      ),
      TarotCard(
        name: 'The Lovers',
        number: 6,
        uprightMeaning: 'Love, harmony, relationships, values alignment, choices',
        reversedMeaning: 'Self-love, disharmony, imbalance, misalignment',
      ),
      TarotCard(
        name: 'The Chariot',
        number: 7,
        uprightMeaning: 'Control, willpower, success, action, determination',
        reversedMeaning: 'Self-discipline, opposition, lack of direction',
      ),
      TarotCard(
        name: 'Strength',
        number: 8,
        uprightMeaning: 'Strength, courage, persuasion, influence, compassion',
        reversedMeaning: 'Inner strength, self-doubt, low energy, raw emotion',
      ),
      TarotCard(
        name: 'The Hermit',
        number: 9,
        uprightMeaning: 'Soul searching, introspection, inner guidance, solitude',
        reversedMeaning: 'Isolation, loneliness, withdrawal from loved ones',
      ),
      TarotCard(
        name: 'Wheel of Fortune',
        number: 10,
        uprightMeaning: 'Good luck, karma, life cycles, destiny, turning point',
        reversedMeaning: 'Bad luck, resistance to change, breaking cycles',
      ),
      TarotCard(
        name: 'Justice',
        number: 11,
        uprightMeaning: 'Justice, fairness, truth, cause and effect, law',
        reversedMeaning: 'Unfairness, lack of accountability, dishonesty',
      ),
      TarotCard(
        name: 'The Hanged Man',
        number: 12,
        uprightMeaning: 'Pause, surrender, letting go, new perspectives',
        reversedMeaning: 'Delays, resistance, stalling, indecision',
      ),
      TarotCard(
        name: 'Death',
        number: 13,
        uprightMeaning: 'Endings, change, transformation, transition',
        reversedMeaning: 'Resistance to change, personal transformation, inner purging',
      ),
      TarotCard(
        name: 'Temperance',
        number: 14,
        uprightMeaning: 'Balance, moderation, patience, purpose, meaning',
        reversedMeaning: 'Imbalance, excess, self-healing, re-alignment',
      ),
      TarotCard(
        name: 'The Devil',
        number: 15,
        uprightMeaning: 'Shadow self, attachment, addiction, restriction, sexuality',
        reversedMeaning: 'Releasing limiting beliefs, exploring dark thoughts, detachment',
      ),
      TarotCard(
        name: 'The Tower',
        number: 16,
        uprightMeaning: 'Sudden change, upheaval, chaos, revelation, awakening',
        reversedMeaning: 'Personal transformation, fear of change, averting disaster',
      ),
      TarotCard(
        name: 'The Star',
        number: 17,
        uprightMeaning: 'Hope, faith, purpose, renewal, spirituality',
        reversedMeaning: 'Lack of faith, despair, self-trust, disconnection',
      ),
      TarotCard(
        name: 'The Moon',
        number: 18,
        uprightMeaning: 'Illusion, fear, anxiety, subconscious, intuition',
        reversedMeaning: 'Release of fear, repressed emotion, inner confusion',
      ),
      TarotCard(
        name: 'The Sun',
        number: 19,
        uprightMeaning: 'Positivity, fun, warmth, success, vitality',
        reversedMeaning: 'Inner child, feeling down, overly optimistic',
      ),
      TarotCard(
        name: 'Judgement',
        number: 20,
        uprightMeaning: 'Judgement, rebirth, inner calling, absolution',
        reversedMeaning: 'Self-doubt, inner critic, ignoring the call',
      ),
      TarotCard(
        name: 'The World',
        number: 21,
        uprightMeaning: 'Completion, integration, accomplishment, travel',
        reversedMeaning: 'Seeking personal closure, short-cuts, delays',
      ),
    ];
  }

  /// Create the 56 Minor Arcana cards (14 cards × 4 suits)
  List<TarotCard> _createMinorArcana() {
    final List<TarotCard> minorArcana = [];
    final suits = ['Wands', 'Cups', 'Swords', 'Pentacles'];
    
    final suitMeanings = {
      'Wands': {
        'upright': 'creativity, inspiration, action, passion',
        'reversed': 'lack of energy, delays, creative blocks',
      },
      'Cups': {
        'upright': 'emotions, relationships, feelings, intuition',
        'reversed': 'emotional instability, blocked feelings, withdrawal',
      },
      'Swords': {
        'upright': 'thoughts, intellect, communication, conflict',
        'reversed': 'confusion, miscommunication, mental fog',
      },
      'Pentacles': {
        'upright': 'material world, finances, career, manifestation',
        'reversed': 'financial loss, lack of planning, materialism',
      },
    };

    for (var suit in suits) {
      // Number cards (Ace through 10)
      for (int i = 1; i <= 10; i++) {
        String cardName = i == 1 ? 'Ace' : i.toString();
        minorArcana.add(
          TarotCard(
            name: '$cardName of $suit',
            number: i,
            suit: suit,
            uprightMeaning: 'Energy of $i in ${suitMeanings[suit]!["upright"]}',
            reversedMeaning: 'Blocked energy of $i in ${suitMeanings[suit]!["reversed"]}',
          ),
        );
      }

      // Court cards
      final courtCards = ['Page', 'Knight', 'Queen', 'King'];
      for (int i = 0; i < courtCards.length; i++) {
        minorArcana.add(
          TarotCard(
            name: '${courtCards[i]} of $suit',
            number: 11 + i,
            suit: suit,
            uprightMeaning: '${courtCards[i]} energy in ${suitMeanings[suit]!["upright"]}',
            reversedMeaning: '${courtCards[i]} challenges in ${suitMeanings[suit]!["reversed"]}',
          ),
        );
      }
    }

    return minorArcana;
  }

  /// Shuffle the deck using Fisher-Yates algorithm
  void shuffle() {
    for (int i = _deck.length - 1; i > 0; i--) {
      int j = _random.nextInt(i + 1);
      var temp = _deck[i];
      _deck[i] = _deck[j];
      _deck[j] = temp;
    }
  }

  /// Draw a specified number of cards from the deck
  /// Each card has a 50% chance of being reversed
  List<TarotCard> drawCards(int count) {
    if (_deck.isEmpty) {
      initializeDeck();
    }

    shuffle();
    
    final drawnCards = <TarotCard>[];
    for (int i = 0; i < count && i < _deck.length; i++) {
      // 50% chance of card being reversed
      bool isReversed = _random.nextBool();
      drawnCards.add(_deck[i].copyWithReversed(isReversed));
    }

    return drawnCards;
  }

  /// Draw a standard 3-card spread (Past, Present, Future)
  List<TarotCard> drawThreeCardSpread() {
    return drawCards(3);
  }

  /// Get spread position names for 3-card reading
  List<String> getThreeCardPositions() {
    return ['Past', 'Present', 'Future'];
  }
}