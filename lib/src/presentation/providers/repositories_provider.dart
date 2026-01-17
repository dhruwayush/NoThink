import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/repositories/hive_decision_repository.dart';
import '../../data/repositories/hive_context_memory_repository.dart';
import '../../domain/repositories/i_decision_repository.dart';
import '../../domain/repositories/i_context_memory_repository.dart';

final decisionRepositoryProvider = Provider<IDecisionRepository>((ref) {
  final box = Hive.box('decisions');
  return HiveDecisionRepository(box);
});

final memoryRepositoryProvider = Provider<IContextMemoryRepository>((ref) {
  final box = Hive.box('context_memories');
  return HiveContextMemoryRepository(box);
});
