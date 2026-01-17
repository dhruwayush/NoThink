import 'package:freezed_annotation/freezed_annotation.dart';

part 'context_memory.freezed.dart';
part 'context_memory.g.dart';

@freezed
abstract class ContextMemory with _$ContextMemory {
  const factory ContextMemory({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'entity_type') required String entityType, // person, place, thing
    @JsonKey(name: 'entity_name') required String entityName,
    required String memory,
    @Default([]) List<String> tags,
    @Default('medium') String priority,
    @JsonKey(name: 'last_triggered') DateTime? lastTriggered,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _ContextMemory;

  factory ContextMemory.fromJson(Map<String, dynamic> json) => _$ContextMemoryFromJson(json);
}
