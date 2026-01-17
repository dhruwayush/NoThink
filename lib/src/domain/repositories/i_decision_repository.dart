import '../models/decision.dart';

abstract class IDecisionRepository {
  Future<List<Decision>> getAllDecisions();
  Future<void> saveDecision(Decision decision);
  Future<void> deleteDecision(String id);
  Future<void> updateDecision(Decision decision);
  Future<void> deleteAll();
  Future<void> syncWithRemote(); // For Supabase sync later
}
