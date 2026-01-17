import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../logic/ranking_service.dart';
import '../../domain/models/recall_result.dart';
import 'decision_provider.dart';
import 'memory_provider.dart';
import 'query_provider.dart';

part 'ranking_provider.g.dart';

@riverpod
class Ranking extends _$Ranking {
  @override
  Future<List<RecallResult>> build() async {
    final query = ref.watch(queryProvider);
    final decisions = await ref.watch(decisionsProvider.future);
    final memories = await ref.watch(memoriesProvider.future);
    
    final service = RankingService();
    return await service.rank(query: query, decisions: decisions, memories: memories);
  }
}
