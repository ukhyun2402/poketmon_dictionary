import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketmon_dictionary/config/router.dart';
import 'package:poketmon_dictionary/config/theme.dart';

void main() {
  runApp(const ProviderScope(child: HomeScreen()));
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: pokdexTheme,
      routerConfig: router,
    );
  }
}
