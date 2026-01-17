import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/models/context_memory.dart';
import '../../domain/repositories/i_context_memory_repository.dart';
import '../services/supabase_service.dart';

class HiveContextMemoryRepository implements IContextMemoryRepository {
  final Box _box;

  HiveContextMemoryRepository(this._box);

  @override
  Future<List<ContextMemory>> getAllMemories() async {
    return _box.values.map((e) => ContextMemory.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Future<void> saveMemory(ContextMemory memory) async {
    await _box.put(memory.id, memory.toJson());

    try {
      final client = SupabaseService().client;
      if (client != null) {
        await client.from('context_memories').upsert(memory.toJson());
      }
    } catch (e) {
      print("Supabase Sync Failed: $e");
    }
  }

  @override
  Future<void> deleteMemory(String id) async {
    await _box.delete(id);

    try {
      final client = SupabaseService().client;
      if (client != null) {
        await client.from('context_memories').delete().eq('id', id);
      }
    } catch (e) {
      print("Supabase Delete Failed: $e");
    }
  }

  @override
  Future<void> updateMemory(ContextMemory memory) async {
    await saveMemory(memory);
  }

  @override
  Future<void> deleteAll() async {
     await _box.clear();
      // Try Delete Remote
    try {
      final client = SupabaseService().client;
      if (client != null) {
        // Warning: This deletes everything for the user matching RLS?
        // Usually dependent on RLS matching user_id()
        // Here we can't easily "delete all", so typically we iterate or leave it.
        // For MVP, assuming a small set, we might not strictly wipe Remote OR 
        // we assume RLS handles "delete from table".
        // Supabase delete requires a filter usually.
        // await client.from('context_memories').delete().neq('id', '0000'); // Delete not equal to dummy
         print("Remote Wipe Not Fully Implemented for safety.");
      }
    } catch (e) {
      print("Supabase Delete Failed: $e");
    }
  }

  @override
  Future<void> syncWithRemote() async {
    try {
      final client = SupabaseService().client;
      if (client == null) return;
      
      // 1. PULL
      try {
        final List<dynamic> remoteData = await client.from('context_memories').select();
        for (final item in remoteData) {
          final memory = ContextMemory.fromJson(item);
          await _box.put(memory.id, memory.toJson());
        }
      } catch (e) {
        print("Pull Failed: $e");
      }

      // 2. PUSH
      final localMemories = _box.values.map((e) => ContextMemory.fromJson(Map<String, dynamic>.from(e))).toList();
      if (localMemories.isNotEmpty) {
          final List<Map<String, dynamic>> data = localMemories.map((e) => e.toJson()).toList();
          await client.from('context_memories').upsert(data);
      }
    } catch (e) {
      print("Full Sync Failed: $e");
    }
  }
}
