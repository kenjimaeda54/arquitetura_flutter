import 'package:ciclar_mobile/data/database/core_database.dart';
import 'package:ciclar_mobile/data/database/contracts/i_posts_resources.dart';
import 'package:ciclar_mobile/data/model/posts/posts_placeholder.dart';
import 'package:ciclar_mobile/di/di.dart';
import 'package:ciclar_mobile/utils/names_table.dart';
import 'package:sqflite/sqflite.dart';

class PostDatabase implements IPostsResources {
  @override
  createPostPlaceHolder(List<PostsPlaceholder> postsPlaceholder) async {
    final db = await getIt<CoreDatabase>().database;
    for (var element in postsPlaceholder) {
      await db.insert(NameTable.postPlaceHolder, element.mapPlaceholder(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<List<PostsPlaceholder>> getPostsPlaceholder() async {
    final db = await getIt<CoreDatabase>().database;
    final List<Map<String, dynamic>> maps =
        await db.query(NameTable.postPlaceHolder);
    return List.generate(maps.length, (i) {
      return PostsPlaceholder.fromJson(maps[i]);
    });
  }
}
