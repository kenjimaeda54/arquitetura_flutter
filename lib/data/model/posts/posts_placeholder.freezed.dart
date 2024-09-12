// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posts_placeholder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostsPlaceholder _$PostsPlaceholderFromJson(Map<String, dynamic> json) {
  return _PostsPlaceholder.fromJson(json);
}

/// @nodoc
mixin _$PostsPlaceholder {
  int get userId => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  int? get createAt => throw _privateConstructorUsedError;

  /// Serializes this PostsPlaceholder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostsPlaceholder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostsPlaceholderCopyWith<PostsPlaceholder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostsPlaceholderCopyWith<$Res> {
  factory $PostsPlaceholderCopyWith(
          PostsPlaceholder value, $Res Function(PostsPlaceholder) then) =
      _$PostsPlaceholderCopyWithImpl<$Res, PostsPlaceholder>;
  @useResult
  $Res call({int userId, int id, String title, String body, int? createAt});
}

/// @nodoc
class _$PostsPlaceholderCopyWithImpl<$Res, $Val extends PostsPlaceholder>
    implements $PostsPlaceholderCopyWith<$Res> {
  _$PostsPlaceholderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostsPlaceholder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? createAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostsPlaceholderImplCopyWith<$Res>
    implements $PostsPlaceholderCopyWith<$Res> {
  factory _$$PostsPlaceholderImplCopyWith(_$PostsPlaceholderImpl value,
          $Res Function(_$PostsPlaceholderImpl) then) =
      __$$PostsPlaceholderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int userId, int id, String title, String body, int? createAt});
}

/// @nodoc
class __$$PostsPlaceholderImplCopyWithImpl<$Res>
    extends _$PostsPlaceholderCopyWithImpl<$Res, _$PostsPlaceholderImpl>
    implements _$$PostsPlaceholderImplCopyWith<$Res> {
  __$$PostsPlaceholderImplCopyWithImpl(_$PostsPlaceholderImpl _value,
      $Res Function(_$PostsPlaceholderImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostsPlaceholder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? createAt = freezed,
  }) {
    return _then(_$PostsPlaceholderImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostsPlaceholderImpl extends _PostsPlaceholder
    with DiagnosticableTreeMixin {
  const _$PostsPlaceholderImpl(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body,
      this.createAt})
      : super._();

  factory _$PostsPlaceholderImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostsPlaceholderImplFromJson(json);

  @override
  final int userId;
  @override
  final int id;
  @override
  final String title;
  @override
  final String body;
  @override
  final int? createAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostsPlaceholder(userId: $userId, id: $id, title: $title, body: $body, createAt: $createAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostsPlaceholder'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('createAt', createAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostsPlaceholderImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, id, title, body, createAt);

  /// Create a copy of PostsPlaceholder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostsPlaceholderImplCopyWith<_$PostsPlaceholderImpl> get copyWith =>
      __$$PostsPlaceholderImplCopyWithImpl<_$PostsPlaceholderImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostsPlaceholderImplToJson(
      this,
    );
  }
}

abstract class _PostsPlaceholder extends PostsPlaceholder {
  const factory _PostsPlaceholder(
      {required final int userId,
      required final int id,
      required final String title,
      required final String body,
      final int? createAt}) = _$PostsPlaceholderImpl;
  const _PostsPlaceholder._() : super._();

  factory _PostsPlaceholder.fromJson(Map<String, dynamic> json) =
      _$PostsPlaceholderImpl.fromJson;

  @override
  int get userId;
  @override
  int get id;
  @override
  String get title;
  @override
  String get body;
  @override
  int? get createAt;

  /// Create a copy of PostsPlaceholder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostsPlaceholderImplCopyWith<_$PostsPlaceholderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
