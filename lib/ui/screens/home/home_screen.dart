import 'package:ciclar_mobile/data/client/data_or_exception.dart';
import 'package:ciclar_mobile/data/model/posts/posts_placeholder.dart';
import 'package:ciclar_mobile/data/repository/posts/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DataOrException<List<PostsPlaceholder>> posts =
        ref.watch(postsRepositoryProvider);

    return Scaffold(
        body: switch (posts.loading) {
      Loading.none => throw UnimplementedError(),
      Loading.loading => const Center(child: CircularProgressIndicator()),
      Loading.success => returnData(data: posts.data!, ref: ref),
      Loading.failure => const Text("error")
    });
  }
}

Widget returnData(
    {required List<PostsPlaceholder> data, required WidgetRef ref}) {
  return (ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () =>
                      GoRouter.of(context).push("/details").then((value) {
                    ref.read(postsRepositoryProvider.notifier).getPosts();
                  }),
                  child: const Text("Navegar para outra tela"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(data[index].title),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Text(data[index].title),
        );
      }));
}
