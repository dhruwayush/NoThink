// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'context_memory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContextMemory {
  String get id;
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'entity_type')
  String get entityType; // person, place, thing
  @JsonKey(name: 'entity_name')
  String get entityName;
  String get memory;
  List<String> get tags;
  String get priority;
  @JsonKey(name: 'last_triggered')
  DateTime? get lastTriggered;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of ContextMemory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContextMemoryCopyWith<ContextMemory> get copyWith =>
      _$ContextMemoryCopyWithImpl<ContextMemory>(
          this as ContextMemory, _$identity);

  /// Serializes this ContextMemory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContextMemory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityName, entityName) ||
                other.entityName == entityName) &&
            (identical(other.memory, memory) || other.memory == memory) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.lastTriggered, lastTriggered) ||
                other.lastTriggered == lastTriggered) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      entityType,
      entityName,
      memory,
      const DeepCollectionEquality().hash(tags),
      priority,
      lastTriggered,
      createdAt);

  @override
  String toString() {
    return 'ContextMemory(id: $id, userId: $userId, entityType: $entityType, entityName: $entityName, memory: $memory, tags: $tags, priority: $priority, lastTriggered: $lastTriggered, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $ContextMemoryCopyWith<$Res> {
  factory $ContextMemoryCopyWith(
          ContextMemory value, $Res Function(ContextMemory) _then) =
      _$ContextMemoryCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'entity_type') String entityType,
      @JsonKey(name: 'entity_name') String entityName,
      String memory,
      List<String> tags,
      String priority,
      @JsonKey(name: 'last_triggered') DateTime? lastTriggered,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$ContextMemoryCopyWithImpl<$Res>
    implements $ContextMemoryCopyWith<$Res> {
  _$ContextMemoryCopyWithImpl(this._self, this._then);

  final ContextMemory _self;
  final $Res Function(ContextMemory) _then;

  /// Create a copy of ContextMemory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? entityType = null,
    Object? entityName = null,
    Object? memory = null,
    Object? tags = null,
    Object? priority = null,
    Object? lastTriggered = freezed,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _self.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityName: null == entityName
          ? _self.entityName
          : entityName // ignore: cast_nullable_to_non_nullable
              as String,
      memory: null == memory
          ? _self.memory
          : memory // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      lastTriggered: freezed == lastTriggered
          ? _self.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ContextMemory implements ContextMemory {
  const _ContextMemory(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'entity_type') required this.entityType,
      @JsonKey(name: 'entity_name') required this.entityName,
      required this.memory,
      final List<String> tags = const [],
      this.priority = 'medium',
      @JsonKey(name: 'last_triggered') this.lastTriggered,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _tags = tags;
  factory _ContextMemory.fromJson(Map<String, dynamic> json) =>
      _$ContextMemoryFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'entity_type')
  final String entityType;
// person, place, thing
  @override
  @JsonKey(name: 'entity_name')
  final String entityName;
  @override
  final String memory;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final String priority;
  @override
  @JsonKey(name: 'last_triggered')
  final DateTime? lastTriggered;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Create a copy of ContextMemory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContextMemoryCopyWith<_ContextMemory> get copyWith =>
      __$ContextMemoryCopyWithImpl<_ContextMemory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContextMemoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContextMemory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityName, entityName) ||
                other.entityName == entityName) &&
            (identical(other.memory, memory) || other.memory == memory) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.lastTriggered, lastTriggered) ||
                other.lastTriggered == lastTriggered) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      entityType,
      entityName,
      memory,
      const DeepCollectionEquality().hash(_tags),
      priority,
      lastTriggered,
      createdAt);

  @override
  String toString() {
    return 'ContextMemory(id: $id, userId: $userId, entityType: $entityType, entityName: $entityName, memory: $memory, tags: $tags, priority: $priority, lastTriggered: $lastTriggered, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$ContextMemoryCopyWith<$Res>
    implements $ContextMemoryCopyWith<$Res> {
  factory _$ContextMemoryCopyWith(
          _ContextMemory value, $Res Function(_ContextMemory) _then) =
      __$ContextMemoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'entity_type') String entityType,
      @JsonKey(name: 'entity_name') String entityName,
      String memory,
      List<String> tags,
      String priority,
      @JsonKey(name: 'last_triggered') DateTime? lastTriggered,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$ContextMemoryCopyWithImpl<$Res>
    implements _$ContextMemoryCopyWith<$Res> {
  __$ContextMemoryCopyWithImpl(this._self, this._then);

  final _ContextMemory _self;
  final $Res Function(_ContextMemory) _then;

  /// Create a copy of ContextMemory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? entityType = null,
    Object? entityName = null,
    Object? memory = null,
    Object? tags = null,
    Object? priority = null,
    Object? lastTriggered = freezed,
    Object? createdAt = null,
  }) {
    return _then(_ContextMemory(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _self.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityName: null == entityName
          ? _self.entityName
          : entityName // ignore: cast_nullable_to_non_nullable
              as String,
      memory: null == memory
          ? _self.memory
          : memory // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      lastTriggered: freezed == lastTriggered
          ? _self.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
