// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_memory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContextMemory _$ContextMemoryFromJson(Map<String, dynamic> json) =>
    _ContextMemory(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      entityType: json['entity_type'] as String,
      entityName: json['entity_name'] as String,
      memory: json['memory'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      priority: json['priority'] as String? ?? 'medium',
      lastTriggered: json['last_triggered'] == null
          ? null
          : DateTime.parse(json['last_triggered'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ContextMemoryToJson(_ContextMemory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'entity_type': instance.entityType,
      'entity_name': instance.entityName,
      'memory': instance.memory,
      'tags': instance.tags,
      'priority': instance.priority,
      'last_triggered': instance.lastTriggered?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
