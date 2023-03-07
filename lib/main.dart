import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketmon_dictionary/service/poketmon_service.dart';
import 'package:poketmon_dictionary/ui/poketmon_tile.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  //TODO: make scroll controller to fetch data more
  @override
  Widget build(BuildContext context) {
    final poketmonsProviderRef = ref.watch(poketmonsProvider);
    return ListView.builder(
      itemBuilder: (context, index) {
        // return Image.network(poketmonsProviderRef[index].imageUrl);
        return PoketmonTile(
          poketmon: poketmonsProviderRef[index],
        );
      },
      itemCount: poketmonsProviderRef.length,
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
