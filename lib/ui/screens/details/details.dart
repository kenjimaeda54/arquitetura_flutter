import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class Details extends HookWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => GoRouter.of(context).pop(true),
          child: const Text("Navegar para outra tela"),
        ),
      ),
    );
  }
}
