import 'package:ciclar_mobile/data/model/posts/posts_placeholder.dart';

abstract class IPostsResources {
  Future<List<PostsPlaceholder>> getPostsPlaceholder();
  createPostPlaceHolder(List<PostsPlaceholder> postsPlaceholder);
}
