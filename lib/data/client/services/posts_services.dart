import 'package:ciclar_mobile/data/client/base_client.dart';
import 'package:ciclar_mobile/data/client/contracts/i_placeholder_posts.dart';
import 'package:ciclar_mobile/data/client/data_or_exception.dart';
import 'package:ciclar_mobile/data/model/posts/posts_placeholder.dart';

class PostsServices extends BaseClient implements IPlaceholderPosts {
  @override
  Future<DataOrException<List<PostsPlaceholder>>> getPostsPlaceholder() async {
    try {
      final response = await customDio().get("/posts");
      return DataOrException(
          data: (response.data as List<dynamic>)
              .map((it) => PostsPlaceholder.fromJson(it))
              .toList(),
          exception: null,
          loading: Loading.success);
    } catch (e) {
      return DataOrException(
          data: null, exception: e.toString(), loading: Loading.failure);
    }
  }
}
