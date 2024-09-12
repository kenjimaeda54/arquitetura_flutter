import 'package:ciclar_mobile/data/database/resources/post_database.dart';
import 'package:ciclar_mobile/data/database/contracts/i_posts_resources.dart';
import 'package:ciclar_mobile/data/model/posts/posts_placeholder.dart';
import 'package:ciclar_mobile/di/di.dart';

class PostsResourceLocal implements IPostsResources {
  @override
  createPostPlaceHolder(List<PostsPlaceholder> postsPlaceholder) {
    getIt<PostDatabase>().createPostPlaceHolder(postsPlaceholder);
  }

  @override
  Future<List<PostsPlaceholder>> getPostsPlaceholder() {
    return getIt<PostDatabase>().getPostsPlaceholder();
  }
}
