// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decision.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Decision {
  String get id;
  @JsonKey(name: 'user_id')
  String get userId;
  String get title;
  @JsonKey(name: 'final_choice')
  String get finalChoice;
  String? get category;
  @JsonKey(name: 'context_tags')
  List<String> get contextTags;
  @JsonKey(name: 'time_of_day')
  String? get timeOfDay;
  @JsonKey(name: 'is_default')
  bool get isDefault;
  @JsonKey(name: 'reuse_count')
  int get reuseCount;
  @JsonKey(name: 'success_score')
  double get successScore;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'last_used_at')
  DateTime get lastUsedAt;

  /// Create a copy of Decision
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DecisionCopyWith<Decision> get copyWith =>
      _$DecisionCopyWithImpl<Decision>(this as Decision, _$identity);

  /// Serializes this Decision to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Decision &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.finalChoice, finalChoice) ||
                other.finalChoice == finalChoice) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality()
                .equals(other.contextTags, contextTags) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.reuseCount, reuseCount) ||
                other.reuseCount == reuseCount) &&
            (identical(other.successScore, successScore) ||
                other.successScore == successScore) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      finalChoice,
      category,
      const DeepCollectionEquality().hash(contextTags),
      timeOfDay,
      isDefault,
      reuseCount,
      successScore,
      createdAt,
      lastUsedAt);

  @override
  String toString() {
    return 'Decision(id: $id, userId: $userId, title: $title, finalChoice: $finalChoice, category: $category, contextTags: $contextTags, timeOfDay: $timeOfDay, isDefault: $isDefault, reuseCount: $reuseCount, successScore: $successScore, createdAt: $createdAt, lastUsedAt: $lastUsedAt)';
  }
}

/// @nodoc
abstract mixin class $DecisionCopyWith<$Res> {
  factory $DecisionCopyWith(Decision value, $Res Function(Decision) _then) =
      _$DecisionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String title,
      @JsonKey(name: 'final_choice') String finalChoice,
      String? category,
      @JsonKey(name: 'context_tags') List<String> contextTags,
      @JsonKey(name: 'time_of_day') String? timeOfDay,
      @JsonKey(name: 'is_default') bool isDefault,
      @JsonKey(name: 'reuse_count') int reuseCount,
      @JsonKey(name: 'success_score') double successScore,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'last_used_at') DateTime lastUsedAt});
}

/// @nodoc
class _$DecisionCopyWithImpl<$Res> implements $DecisionCopyWith<$Res> {
  _$DecisionCopyWithImpl(this._self, this._then);

  final Decision _self;
  final $Res Function(Decision) _then;

  /// Create a copy of Decision
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? finalChoice = null,
    Object? category = freezed,
    Object? contextTags = null,
    Object? timeOfDay = freezed,
    Object? isDefault = null,
    Object? reuseCount = null,
    Object? successScore = null,
    Object? createdAt = null,
    Object? lastUsedAt = null,
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
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      finalChoice: null == finalChoice
          ? _self.finalChoice
          : finalChoice // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      contextTags: null == contextTags
          ? _self.contextTags
          : contextTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timeOfDay: freezed == timeOfDay
          ? _self.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      reuseCount: null == reuseCount
          ? _self.reuseCount
          : reuseCount // ignore: cast_nullable_to_non_nullable
              as int,
      successScore: null == successScore
          ? _self.successScore
          : successScore // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUsedAt: null == lastUsedAt
          ? _self.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Decision implements Decision {
  const _Decision(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      required this.title,
      @JsonKey(name: 'final_choice') required this.finalChoice,
      this.category,
      @JsonKey(name: 'context_tags') final List<String> contextTags = const [],
      @JsonKey(name: 'time_of_day') this.timeOfDay,
      @JsonKey(name: 'is_default') this.isDefault = false,
      @JsonKey(name: 'reuse_count') this.reuseCount = 0,
      @JsonKey(name: 'success_score') this.successScore = 0.0,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'last_used_at') required this.lastUsedAt})
      : _contextTags = contextTags;
  factory _Decision.fromJson(Map<String, dynamic> json) =>
      _$DecisionFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String title;
  @override
  @JsonKey(name: 'final_choice')
  final String finalChoice;
  @override
  final String? category;
  final List<String> _contextTags;
  @override
  @JsonKey(name: 'context_tags')
  List<String> get contextTags {
    if (_contextTags is EqualUnmodifiableListView) return _contextTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contextTags);
  }

  @override
  @JsonKey(name: 'time_of_day')
  final String? timeOfDay;
  @override
  @JsonKey(name: 'is_default')
  final bool isDefault;
  @override
  @JsonKey(name: 'reuse_count')
  final int reuseCount;
  @override
  @JsonKey(name: 'success_score')
  final double successScore;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'last_used_at')
  final DateTime lastUsedAt;

  /// Create a copy of Decision
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DecisionCopyWith<_Decision> get copyWith =>
      __$DecisionCopyWithImpl<_Decision>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DecisionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Decision &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.finalChoice, finalChoice) ||
                other.finalChoice == finalChoice) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality()
                .equals(other._contextTags, _contextTags) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.reuseCount, reuseCount) ||
                other.reuseCount == reuseCount) &&
            (identical(other.successScore, successScore) ||
                other.successScore == successScore) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      finalChoice,
      category,
      const DeepCollectionEquality().hash(_contextTags),
      timeOfDay,
      isDefault,
      reuseCount,
      successScore,
      createdAt,
      lastUsedAt);

  @override
  String toString() {
    return 'Decision(id: $id, userId: $userId, title: $title, finalChoice: $finalChoice, category: $category, contextTags: $contextTags, timeOfDay: $timeOfDay, isDefault: $isDefault, reuseCount: $reuseCount, successScore: $successScore, createdAt: $createdAt, lastUsedAt: $lastUsedAt)';
  }
}

/// @nodoc
abstract mixin class _$DecisionCopyWith<$Res>
    implements $DecisionCopyWith<$Res> {
  factory _$DecisionCopyWith(_Decision value, $Res Function(_Decision) _then) =
      __$DecisionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String title,
      @JsonKey(name: 'final_choice') String finalChoice,
      String? category,
      @JsonKey(name: 'context_tags') List<String> contextTags,
      @JsonKey(name: 'time_of_day') String? timeOfDay,
      @JsonKey(name: 'is_default') bool isDefault,
      @JsonKey(name: 'reuse_count') int reuseCount,
      @JsonKey(name: 'success_score') double successScore,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'last_used_at') DateTime lastUsedAt});
}

/// @nodoc
class __$DecisionCopyWithImpl<$Res> implements _$DecisionCopyWith<$Res> {
  __$DecisionCopyWithImpl(this._self, this._then);

  final _Decision _self;
  final $Res Function(_Decision) _then;

  /// Create a copy of Decision
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? finalChoice = null,
    Object? category = freezed,
    Object? contextTags = null,
    Object? timeOfDay = freezed,
    Object? isDefault = null,
    Object? reuseCount = null,
    Object? successScore = null,
    Object? createdAt = null,
    Object? lastUsedAt = null,
  }) {
    return _then(_Decision(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      finalChoice: null == finalChoice
          ? _self.finalChoice
          : finalChoice // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      contextTags: null == contextTags
          ? _self._contextTags
          : contextTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timeOfDay: freezed == timeOfDay
          ? _self.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      reuseCount: null == reuseCount
          ? _self.reuseCount
          : reuseCount // ignore: cast_nullable_to_non_nullable
              as int,
      successScore: null == successScore
          ? _self.successScore
          : successScore // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUsedAt: null == lastUsedAt
          ? _self.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
