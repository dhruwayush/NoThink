import 'package:freezed_annotation/freezed_annotation.dart';
import 'decision.dart';
import 'context_memory.dart';

part 'recall_result.freezed.dart';

@freezed
sealed class RecallResult with _$RecallResult {
  const factory RecallResult.valDecision(Decision decision) = ValDecision;
  const factory RecallResult.valMemory(ContextMemory memory) = ValMemory;
  const factory RecallResult.valSuggestion(String suggestion) = ValSuggestion;
}
