import 'package:freezed_annotation/freezed_annotation.dart';

part 'decision.freezed.dart';
part 'decision.g.dart';

@freezed
abstract class Decision with _$Decision {
  const factory Decision({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String title,
    @JsonKey(name: 'final_choice') required String finalChoice,
    String? category,
    @JsonKey(name: 'context_tags') @Default([]) List<String> contextTags,
    @JsonKey(name: 'time_of_day') String? timeOfDay,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
    @JsonKey(name: 'reuse_count') @Default(0) int reuseCount,
    @JsonKey(name: 'success_score') @Default(0.0) double successScore,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'last_used_at') required DateTime lastUsedAt,
  }) = _Decision;

  factory Decision.fromJson(Map<String, dynamic> json) => _$DecisionFromJson(json);
}
