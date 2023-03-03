import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketmon_dictionary/service/poketmon_service.dart';
import 'components/poketmon_tile.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController()..addListener(meetEndOfScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final poketmonPageIndex = ref.watch(poketmonPaginationProvider);
    final poketmonsProviderRef =
        ref.watch(poketmonsProvider(poketmonPageIndex));
    return ListView.builder(
      controller: _controller,
      itemBuilder: (context, index) {
        return PoketmonTile(poketmon: poketmonsProviderRef[index]);
      },
      itemCount: poketmonsProviderRef.length,
    );
  }

  void meetEndOfScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      ref.read(poketmonPaginationProvider.notifier).state++;
    }
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSansKR'),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("포켓몬 도감"),
        ),
        body: const MainScreen(),
      ),
    );
  }
}
