import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reading.dart';

/// Service for managing Firebase Firestore operations
/// Handles storage and retrieval of readings and user data
class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Collection names
  static const String _readingsCollection = 'readings';
  static const String _usersCollection = 'users';
  static const String _chatHistoryCollection = 'chat_history';

  /// Save a reading to Firestore
  Future<void> saveReading(Reading reading) async {
    try {
      await _firestore
          .collection(_readingsCollection)
          .doc(reading.id)
          .set(reading.toJson());
    } catch (e) {
      throw Exception('Failed to save reading: $e');
    }
  }

  /// Get all readings for a specific user
  Future<List<Reading>> getUserReadings(String userId, {int limit = 20}) async {
    try {
      final querySnapshot = await _firestore
          .collection(_readingsCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => Reading.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch readings: $e');
    }
  }

  /// Get a specific reading by ID
  Future<Reading?> getReading(String readingId) async {
    try {
      final doc = await _firestore
          .collection(_readingsCollection)
          .doc(readingId)
          .get();

      if (doc.exists) {
        return Reading.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch reading: $e');
    }
  }

  /// Delete a reading
  Future<void> deleteReading(String readingId) async {
    try {
      await _firestore
          .collection(_readingsCollection)
          .doc(readingId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete reading: $e');
    }
  }

  /// Save a chat message to history
  Future<void> saveChatMessage({
    required String userId,
    required String message,
    required bool isUser,
  }) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_chatHistoryCollection)
          .add({
        'message': message,
        'isUser': isUser,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save chat message: $e');
    }
  }

  /// Get chat history for a user
  Future<List<Map<String, dynamic>>> getChatHistory(
    String userId, {
    int limit = 50,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_chatHistoryCollection)
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => {
                'message': doc.data()['message'],
                'isUser': doc.data()['isUser'],
                'timestamp': doc.data()['timestamp'],
              })
          .toList()
          .reversed
          .toList(); // Reverse to show oldest first
    } catch (e) {
      throw Exception('Failed to fetch chat history: $e');
    }
  }

  /// Update user profile/preferences
  Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .set(data, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  /// Get user profile
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .get();

      return doc.data();
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }
}