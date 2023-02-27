import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketmon_dictionary/model/poketmon.dart';
import 'package:poketmon_dictionary/service/poketmon_service.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final poketmonProviderRef = ref.watch(poketmonProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          poketmonProviderRef.when(
              data: (data) => Text(data.data),
              error: (e, s) => Text("Error $e"),
              loading: () => const CircularProgressIndicator())
        ],
      ),
    );
  }

  // List<Poketmon>
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("포켓몬 도감"),
        ),
        body: const MainScreen(),
      ),
    );
  }
}
