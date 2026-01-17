import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/decision.dart';
import 'repositories_provider.dart';

part 'decision_provider.g.dart';

@riverpod
class Decisions extends _$Decisions {
  @override
  Future<List<Decision>> build() async {
    final repo = ref.watch(decisionRepositoryProvider);
    return repo.getAllDecisions();
  }

  Future<void> addDecision(Decision decision) async {
    final repo = ref.read(decisionRepositoryProvider);
    await repo.saveDecision(decision);
    ref.invalidateSelf();
  }

  Future<void> updateDecision(Decision decision) async {
    final repo = ref.read(decisionRepositoryProvider);
    await repo.updateDecision(decision);
    ref.invalidateSelf();
  }

  Future<void> clearAll() async {
    final repo = ref.read(decisionRepositoryProvider);
    await repo.deleteAll();
    ref.invalidateSelf();
  }
}
