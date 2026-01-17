import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/models/decision.dart';
import '../../domain/repositories/i_decision_repository.dart';
import '../services/supabase_service.dart';

class HiveDecisionRepository implements IDecisionRepository {
  final Box _box;

  HiveDecisionRepository(this._box);

  @override
  Future<List<Decision>> getAllDecisions() async {
    return _box.values.map((e) => Decision.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Future<void> saveDecision(Decision decision) async {
    // 1. Save Local
    await _box.put(decision.id, decision.toJson());

    // 2. Try Save Remote
    try {
      final client = SupabaseService().client;
      if (client != null) {
        // Upsert to handle both create and update
        await client.from('decisions').upsert(decision.toJson());
      }
    } catch (e) {
      // Fail silently for offline-first, maybe log to a queue later
      print("Supabase Sync Failed: $e");
    }
  }

  @override
  Future<void> deleteDecision(String id) async {
    // 1. Delete Local
    await _box.delete(id);

    // 2. Try Delete Remote
    try {
      final client = SupabaseService().client;
      if (client != null) {
        await client.from('decisions').delete().eq('id', id);
      }
    } catch (e) {
      print("Supabase Delete Failed: $e");
    }
  }

  @override
  Future<void> updateDecision(Decision decision) async {
    await saveDecision(decision); // Reuse upsert logic, same as save
  }

  @override
  Future<void> deleteAll() async {
     await _box.clear();
     // Remote wipe logic is non-trivial without a dedicated rpc or loop.
     // For now, we only clear local cache as "Wipe All Memories" implies device data primarily to user here.
  }

  @override
  Future<void> syncWithRemote() async {
    try {
      final client = SupabaseService().client;
      if (client == null) return;
      
      // 1. PULL from Remote (Server is Single Source of Truth for now)
      try {
        final List<dynamic> remoteData = await client.from('decisions').select();
        for (final item in remoteData) {
          final decision = Decision.fromJson(item);
          await _box.put(decision.id, decision.toJson());
        }
      } catch (e) {
        print("Pull Failed: $e");
      }

      // 2. PUSH Local to Remote
      // (For MVP, we push everything local back to ensure consistency, 
      // though ideally we'd use dirty flags)
      final localDetails = _box.values.map((e) => Decision.fromJson(Map<String, dynamic>.from(e))).toList();
      if (localDetails.isNotEmpty) {
          final List<Map<String, dynamic>> data = localDetails.map((e) => e.toJson()).toList();
          await client.from('decisions').upsert(data);
      }
      
    } catch (e) {
      print("Full Sync Failed: $e");
    }
  }
}
