import 'package:ciclar_mobile/data/client/contracts/i_placeholder_posts.dart';
import 'package:ciclar_mobile/data/client/services/posts_services.dart';
import 'package:ciclar_mobile/data/database/contracts/i_posts_resources.dart';
import 'package:ciclar_mobile/data/database/core_database.dart';
import 'package:ciclar_mobile/data/database/resources/post_database.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<IPlaceholderPosts>(() => PostsServices());
  getIt.registerSingleton<CoreDatabase>(CoreDatabase());
  getIt.registerSingleton<IPostsResources>(PostDatabase());
}
