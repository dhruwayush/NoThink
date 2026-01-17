import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/context_memory.dart';
import 'repositories_provider.dart';

part 'memory_provider.g.dart';

@riverpod
class Memories extends _$Memories {
  @override
  Future<List<ContextMemory>> build() async {
    final repo = ref.watch(memoryRepositoryProvider);
    return repo.getAllMemories();
  }

  Future<void> addMemory(ContextMemory memory) async {
    final repo = ref.read(memoryRepositoryProvider);
    await repo.saveMemory(memory);
    ref.invalidateSelf();
  }

  Future<void> updateMemory(ContextMemory memory) async {
    final repo = ref.read(memoryRepositoryProvider);
    await repo.updateMemory(memory);
    ref.invalidateSelf();
  }

  Future<void> clearAll() async {
    final repo = ref.read(memoryRepositoryProvider);
    await repo.deleteAll();
    ref.invalidateSelf();
  }
}
