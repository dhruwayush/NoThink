// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recall_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecallResult {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RecallResult);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RecallResult()';
  }
}

/// @nodoc
class $RecallResultCopyWith<$Res> {
  $RecallResultCopyWith(RecallResult _, $Res Function(RecallResult) __);
}

/// @nodoc

class ValDecision implements RecallResult {
  const ValDecision(this.decision);

  final Decision decision;

  /// Create a copy of RecallResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ValDecisionCopyWith<ValDecision> get copyWith =>
      _$ValDecisionCopyWithImpl<ValDecision>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ValDecision &&
            (identical(other.decision, decision) ||
                other.decision == decision));
  }

  @override
  int get hashCode => Object.hash(runtimeType, decision);

  @override
  String toString() {
    return 'RecallResult.valDecision(decision: $decision)';
  }
}

/// @nodoc
abstract mixin class $ValDecisionCopyWith<$Res>
    implements $RecallResultCopyWith<$Res> {
  factory $ValDecisionCopyWith(
          ValDecision value, $Res Function(ValDecision) _then) =
      _$ValDecisionCopyWithImpl;
  @useResult
  $Res call({Decision decision});

  $DecisionCopyWith<$Res> get decision;
}

/// @nodoc
class _$ValDecisionCopyWithImpl<$Res> implements $ValDecisionCopyWith<$Res> {
  _$ValDecisionCopyWithImpl(this._self, this._then);

  final ValDecision _self;
  final $Res Function(ValDecision) _then;

  /// Create a copy of RecallResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? decision = null,
  }) {
    return _then(ValDecision(
      null == decision
          ? _self.decision
          : decision // ignore: cast_nullable_to_non_nullable
              as Decision,
    ));
  }

  /// Create a copy of RecallResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DecisionCopyWith<$Res> get decision {
    return $DecisionCopyWith<$Res>(_self.decision, (value) {
      return _then(_self.copyWith(decision: value));
    });
  }
}

/// @nodoc

class ValMemory implements RecallResult {
  const ValMemory(this.memory);

  final ContextMemory memory;

  /// Create a copy of RecallResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ValMemoryCopyWith<ValMemory> get copyWith =>
      _$ValMemoryCopyWithImpl<ValMemory>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ValMemory &&
            (identical(other.memory, memory) || other.memory == memory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, memory);

  @override
  String toString() {
    return 'RecallResult.valMemory(memory: $memory)';
  }
}

/// @nodoc
abstract mixin class $ValMemoryCopyWith<$Res>
    implements $RecallResultCopyWith<$Res> {
  factory $ValMemoryCopyWith(ValMemory value, $Res Function(ValMemory) _then) =
      _$ValMemoryCopyWithImpl;
  @useResult
  $Res call({ContextMemory memory});

  $ContextMemoryCopyWith<$Res> get memory;
}

/// @nodoc
class _$ValMemoryCopyWithImpl<$Res> implements $ValMemoryCopyWith<$Res> {
  _$ValMemoryCopyWithImpl(this._self, this._then);

  final ValMemory _self;
  final $Res Function(ValMemory) _then;

  /// Create a copy of RecallResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? memory = null,
  }) {
    return _then(ValMemory(
      null == memory
          ? _self.memory
          : memory // ignore: cast_nullable_to_non_nullable
              as ContextMemory,
    ));
  }

  /// Create a copy of RecallResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContextMemoryCopyWith<$Res> get memory {
    return $ContextMemoryCopyWith<$Res>(_self.memory, (value) {
      return _then(_self.copyWith(memory: value));
    });
  }
}

/// @nodoc

class ValSuggestion implements RecallResult {
  const ValSuggestion(this.suggestion);

  final String suggestion;

  /// Create a copy of RecallResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ValSuggestionCopyWith<ValSuggestion> get copyWith =>
      _$ValSuggestionCopyWithImpl<ValSuggestion>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ValSuggestion &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, suggestion);

  @override
  String toString() {
    return 'RecallResult.valSuggestion(suggestion: $suggestion)';
  }
}

/// @nodoc
abstract mixin class $ValSuggestionCopyWith<$Res>
    implements $RecallResultCopyWith<$Res> {
  factory $ValSuggestionCopyWith(
          ValSuggestion value, $Res Function(ValSuggestion) _then) =
      _$ValSuggestionCopyWithImpl;
  @useResult
  $Res call({String suggestion});
}

/// @nodoc
class _$ValSuggestionCopyWithImpl<$Res>
    implements $ValSuggestionCopyWith<$Res> {
  _$ValSuggestionCopyWithImpl(this._self, this._then);

  final ValSuggestion _self;
  final $Res Function(ValSuggestion) _then;

  /// Create a copy of RecallResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? suggestion = null,
  }) {
    return _then(ValSuggestion(
      null == suggestion
          ? _self.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
