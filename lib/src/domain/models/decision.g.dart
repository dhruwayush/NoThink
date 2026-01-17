// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Decision _$DecisionFromJson(Map<String, dynamic> json) => _Decision(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      finalChoice: json['final_choice'] as String,
      category: json['category'] as String?,
      contextTags: (json['context_tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      timeOfDay: json['time_of_day'] as String?,
      isDefault: json['is_default'] as bool? ?? false,
      reuseCount: (json['reuse_count'] as num?)?.toInt() ?? 0,
      successScore: (json['success_score'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastUsedAt: DateTime.parse(json['last_used_at'] as String),
    );

Map<String, dynamic> _$DecisionToJson(_Decision instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'final_choice': instance.finalChoice,
      'category': instance.category,
      'context_tags': instance.contextTags,
      'time_of_day': instance.timeOfDay,
      'is_default': instance.isDefault,
      'reuse_count': instance.reuseCount,
      'success_score': instance.successScore,
      'created_at': instance.createdAt.toIso8601String(),
      'last_used_at': instance.lastUsedAt.toIso8601String(),
    };
