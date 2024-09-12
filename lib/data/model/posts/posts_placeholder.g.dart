// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_placeholder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostsPlaceholderImpl _$$PostsPlaceholderImplFromJson(
        Map<String, dynamic> json) =>
    _$PostsPlaceholderImpl(
      userId: (json['userId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
      createAt: (json['createAt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PostsPlaceholderImplToJson(
        _$PostsPlaceholderImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'createAt': instance.createAt,
    };
