import 'package:ciclar_mobile/data/client/data_or_exception.dart';
import 'package:ciclar_mobile/data/model/posts/posts_placeholder.dart';

abstract class IPlaceholderPosts {
  Future<DataOrException<List<PostsPlaceholder>>> getPostsPlaceholder();
}
