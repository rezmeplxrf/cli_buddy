// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WebSocketState {
  SocketState get connectionState => throw _privateConstructorUsedError;
  MessageChunk? get chunk => throw _privateConstructorUsedError;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSocketStateCopyWith<WebSocketState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSocketStateCopyWith<$Res> {
  factory $WebSocketStateCopyWith(
          WebSocketState value, $Res Function(WebSocketState) then) =
      _$WebSocketStateCopyWithImpl<$Res, WebSocketState>;
  @useResult
  $Res call({SocketState connectionState, MessageChunk? chunk});

  $MessageChunkCopyWith<$Res>? get chunk;
}

/// @nodoc
class _$WebSocketStateCopyWithImpl<$Res, $Val extends WebSocketState>
    implements $WebSocketStateCopyWith<$Res> {
  _$WebSocketStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connectionState = null,
    Object? chunk = freezed,
  }) {
    return _then(_value.copyWith(
      connectionState: null == connectionState
          ? _value.connectionState
          : connectionState // ignore: cast_nullable_to_non_nullable
              as SocketState,
      chunk: freezed == chunk
          ? _value.chunk
          : chunk // ignore: cast_nullable_to_non_nullable
              as MessageChunk?,
    ) as $Val);
  }

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageChunkCopyWith<$Res>? get chunk {
    if (_value.chunk == null) {
      return null;
    }

    return $MessageChunkCopyWith<$Res>(_value.chunk!, (value) {
      return _then(_value.copyWith(chunk: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WebSocketStateImplCopyWith<$Res>
    implements $WebSocketStateCopyWith<$Res> {
  factory _$$WebSocketStateImplCopyWith(_$WebSocketStateImpl value,
          $Res Function(_$WebSocketStateImpl) then) =
      __$$WebSocketStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SocketState connectionState, MessageChunk? chunk});

  @override
  $MessageChunkCopyWith<$Res>? get chunk;
}

/// @nodoc
class __$$WebSocketStateImplCopyWithImpl<$Res>
    extends _$WebSocketStateCopyWithImpl<$Res, _$WebSocketStateImpl>
    implements _$$WebSocketStateImplCopyWith<$Res> {
  __$$WebSocketStateImplCopyWithImpl(
      _$WebSocketStateImpl _value, $Res Function(_$WebSocketStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connectionState = null,
    Object? chunk = freezed,
  }) {
    return _then(_$WebSocketStateImpl(
      connectionState: null == connectionState
          ? _value.connectionState
          : connectionState // ignore: cast_nullable_to_non_nullable
              as SocketState,
      chunk: freezed == chunk
          ? _value.chunk
          : chunk // ignore: cast_nullable_to_non_nullable
              as MessageChunk?,
    ));
  }
}

/// @nodoc

class _$WebSocketStateImpl implements _WebSocketState {
  const _$WebSocketStateImpl({required this.connectionState, this.chunk});

  @override
  final SocketState connectionState;
  @override
  final MessageChunk? chunk;

  @override
  String toString() {
    return 'WebSocketState(connectionState: $connectionState, chunk: $chunk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketStateImpl &&
            (identical(other.connectionState, connectionState) ||
                other.connectionState == connectionState) &&
            (identical(other.chunk, chunk) || other.chunk == chunk));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connectionState, chunk);

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketStateImplCopyWith<_$WebSocketStateImpl> get copyWith =>
      __$$WebSocketStateImplCopyWithImpl<_$WebSocketStateImpl>(
          this, _$identity);
}

abstract class _WebSocketState implements WebSocketState {
  const factory _WebSocketState(
      {required final SocketState connectionState,
      final MessageChunk? chunk}) = _$WebSocketStateImpl;

  @override
  SocketState get connectionState;
  @override
  MessageChunk? get chunk;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketStateImplCopyWith<_$WebSocketStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
