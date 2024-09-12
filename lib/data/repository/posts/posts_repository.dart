import 'package:ciclar_mobile/data/client/contracts/i_placeholder_posts.dart';
import 'package:ciclar_mobile/data/client/data_or_exception.dart';
import 'package:ciclar_mobile/data/database/contracts/i_posts_resources.dart';
import 'package:ciclar_mobile/data/model/posts/posts_placeholder.dart';
import 'package:ciclar_mobile/di/di.dart';
import 'package:ciclar_mobile/utils/helpers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_repository.g.dart';

@riverpod
class PostsRepository extends _$PostsRepository {
  @override
  DataOrException<List<PostsPlaceholder>> build() {
    getPosts();
    return DataOrException(
        data: null, exception: null, loading: Loading.loading);
  }

  getPosts() async {
    final resultLocal = await getIt<IPostsResources>().getPostsPlaceholder();
    if (resultLocal.isNotEmpty) {
      final helper = Helpers();
      final canUpdate = await helper.shouldUpdateOrNoDatabase(
          compare: resultLocal[0].createAt, withTimeMinutes: 1);
      if (canUpdate) {
        final resultRemote =
            await getIt<IPlaceholderPosts>().getPostsPlaceholder();
        getIt<IPostsResources>().createPostPlaceHolder(resultRemote.data!);
        state = resultRemote;
        return;
      }

      state = DataOrException(
          data: resultLocal, exception: null, loading: Loading.success);
      return;
    }
    final resultRemote = await getIt<IPlaceholderPosts>().getPostsPlaceholder();
    getIt<IPostsResources>().createPostPlaceHolder(resultRemote.data!);
    state = resultRemote;
  }
}
