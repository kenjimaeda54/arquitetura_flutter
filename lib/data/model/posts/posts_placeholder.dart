import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_placeholder.freezed.dart';
part 'posts_placeholder.g.dart';

abstract class PostsPlaceHolderDatabase {
  Map<String, dynamic> mapPlaceholder();
}

@freezed
class PostsPlaceholder
    with _$PostsPlaceholder
    implements PostsPlaceHolderDatabase {
  const PostsPlaceholder._();
  const factory PostsPlaceholder({
    required int userId,
    required int id,
    required String title,
    required String body,
    int? createAt,
  }) = _PostsPlaceholder;

  factory PostsPlaceholder.fromJson(Map<String, dynamic> json) =>
      _$PostsPlaceholderFromJson(json);

  factory PostsPlaceholder.fromEmpty() => const PostsPlaceholder(
        userId: 0,
        id: 0,
        title: '',
        body: '',
      );

  @override
  Map<String, dynamic> mapPlaceholder() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
        'createAt': DateTime.now().millisecondsSinceEpoch,
      };
}
