// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ducktor_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DucktorResponse {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> data) success,
    required TResult Function(String message) error,
    required TResult Function(String message) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message)? error,
    TResult Function(String message)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message)? error,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OK value) success,
    required TResult Function(ERROR value) error,
    required TResult Function(LOADING value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OK value)? success,
    TResult Function(ERROR value)? error,
    TResult Function(LOADING value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OK value)? success,
    TResult Function(ERROR value)? error,
    TResult Function(LOADING value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DucktorResponseCopyWith<$Res> {
  factory $DucktorResponseCopyWith(
          DucktorResponse value, $Res Function(DucktorResponse) then) =
      _$DucktorResponseCopyWithImpl<$Res>;
}

/// @nodoc
class _$DucktorResponseCopyWithImpl<$Res>
    implements $DucktorResponseCopyWith<$Res> {
  _$DucktorResponseCopyWithImpl(this._value, this._then);

  final DucktorResponse _value;
  // ignore: unused_field
  final $Res Function(DucktorResponse) _then;
}

/// @nodoc
abstract class _$$OKCopyWith<$Res> {
  factory _$$OKCopyWith(_$OK value, $Res Function(_$OK) then) =
      __$$OKCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$OKCopyWithImpl<$Res> extends _$DucktorResponseCopyWithImpl<$Res>
    implements _$$OKCopyWith<$Res> {
  __$$OKCopyWithImpl(_$OK _value, $Res Function(_$OK) _then)
      : super(_value, (v) => _then(v as _$OK));

  @override
  _$OK get _value => super._value as _$OK;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$OK(
      data == freezed
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$OK with DiagnosticableTreeMixin implements OK {
  const _$OK(final Map<String, dynamic> data) : _data = data;

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DucktorResponse.success(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DucktorResponse.success'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OK &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  _$$OKCopyWith<_$OK> get copyWith =>
      __$$OKCopyWithImpl<_$OK>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> data) success,
    required TResult Function(String message) error,
    required TResult Function(String message) loading,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message)? error,
    TResult Function(String message)? loading,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message)? error,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OK value) success,
    required TResult Function(ERROR value) error,
    required TResult Function(LOADING value) loading,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OK value)? success,
    TResult Function(ERROR value)? error,
    TResult Function(LOADING value)? loading,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OK value)? success,
    TResult Function(ERROR value)? error,
    TResult Function(LOADING value)? loading,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class OK implements DucktorResponse {
  const factory OK(final Map<String, dynamic> data) = _$OK;

  Map<String, dynamic> get data;
  @JsonKey(ignore: true)
  _$$OKCopyWith<_$OK> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ERRORCopyWith<$Res> {
  factory _$$ERRORCopyWith(_$ERROR value, $Res Function(_$ERROR) then) =
      __$$ERRORCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$ERRORCopyWithImpl<$Res> extends _$DucktorResponseCopyWithImpl<$Res>
    implements _$$ERRORCopyWith<$Res> {
  __$$ERRORCopyWithImpl(_$ERROR _value, $Res Function(_$ERROR) _then)
      : super(_value, (v) => _then(v as _$ERROR));

  @override
  _$ERROR get _value => super._value as _$ERROR;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ERROR(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ERROR with DiagnosticableTreeMixin implements ERROR {
  const _$ERROR(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DucktorResponse.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DucktorResponse.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ERROR &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$ERRORCopyWith<_$ERROR> get copyWith =>
      __$$ERRORCopyWithImpl<_$ERROR>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> data) success,
    required TResult Function(String message) error,
    required TResult Function(String message) loading,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message)? error,
    TResult Function(String message)? loading,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message)? error,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OK value) success,
    required TResult Function(ERROR value) error,
    required TResult Function(LOADING value) loading,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OK value)? success,
    TResult Function(ERROR value)? error,
    TResult Function(LOADING value)? loading,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OK value)? success,
    TResult Function(ERROR value)? error,
    TResult Function(LOADING value)? loading,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ERROR implements DucktorResponse {
  const factory ERROR(final String message) = _$ERROR;

  String get message;
  @JsonKey(ignore: true)
  _$$ERRORCopyWith<_$ERROR> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LOADINGCopyWith<$Res> {
  factory _$$LOADINGCopyWith(_$LOADING value, $Res Function(_$LOADING) then) =
      __$$LOADINGCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$LOADINGCopyWithImpl<$Res> extends _$DucktorResponseCopyWithImpl<$Res>
    implements _$$LOADINGCopyWith<$Res> {
  __$$LOADINGCopyWithImpl(_$LOADING _value, $Res Function(_$LOADING) _then)
      : super(_value, (v) => _then(v as _$LOADING));

  @override
  _$LOADING get _value => super._value as _$LOADING;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$LOADING(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LOADING with DiagnosticableTreeMixin implements LOADING {
  const _$LOADING(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DucktorResponse.loading(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DucktorResponse.loading'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LOADING &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$LOADINGCopyWith<_$LOADING> get copyWith =>
      __$$LOADINGCopyWithImpl<_$LOADING>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> data) success,
    required TResult Function(String message) error,
    required TResult Function(String message) loading,
  }) {
    return loading(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message)? error,
    TResult Function(String message)? loading,
  }) {
    return loading?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message)? error,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OK value) success,
    required TResult Function(ERROR value) error,
    required TResult Function(LOADING value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OK value)? success,
    TResult Function(ERROR value)? error,
    TResult Function(LOADING value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OK value)? success,
    TResult Function(ERROR value)? error,
    TResult Function(LOADING value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LOADING implements DucktorResponse {
  const factory LOADING(final String message) = _$LOADING;

  String get message;
  @JsonKey(ignore: true)
  _$$LOADINGCopyWith<_$LOADING> get copyWith =>
      throw _privateConstructorUsedError;
}
