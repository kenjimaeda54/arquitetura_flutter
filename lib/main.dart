import 'package:ciclar_mobile/di/di.dart';
import 'package:ciclar_mobile/ui/screens/details/details.dart';
import 'package:ciclar_mobile/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  setup();
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _route = GoRouter(routes: [
    GoRoute(
        path: "/",
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
              path: "details", builder: (context, state) => const Details()),
        ])
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _route,
    );
  }
}
