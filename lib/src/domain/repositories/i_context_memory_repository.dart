import '../models/context_memory.dart';

abstract class IContextMemoryRepository {
  Future<List<ContextMemory>> getAllMemories();
  Future<void> saveMemory(ContextMemory memory);
  Future<void> deleteMemory(String id);
  Future<void> updateMemory(ContextMemory memory);
  Future<void> deleteAll();
  Future<void> syncWithRemote();
}
