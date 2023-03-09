import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:poketmon_dictionary/components/poketmon_tile.dart';
import 'package:poketmon_dictionary/service/poketmon_service.dart';
import 'package:poketmon_dictionary/service/ui_service.dart';
import 'package:poketmon_dictionary/ui/pokedex_appbar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController()..addListener(scrollControllerEvent);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //==================state==================
    final poketmonPageIndex = ref.watch(poketmonPaginationProvider);
    final poketmonsProviderRef =
        ref.watch(poketmonsProvider(poketmonPageIndex));
    final appbarVisible = ref.watch(scrollDirectionProvider);
    final atTop = ref.watch(scrollToUpperProvider);
    //==================state==================
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PokedexAppbar(appbarVisible: appbarVisible, atTop: atTop),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return ListView.builder(
            controller: _controller,
            itemBuilder: (context, index) {
              return PoketmonTile(poketmon: poketmonsProviderRef[index]);
            },
            itemCount: poketmonsProviderRef.length,
          );
        } else {
          return GridView.builder(
              controller: _controller,
              itemCount: poketmonsProviderRef.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 1),
              itemBuilder: (context, index) {
                return PoketmonTile(poketmon: poketmonsProviderRef[index]);
              });
        }
      }),
    );
  }

  void scrollControllerEvent() {
    final srcollProvider = ref.read(scrollDirectionProvider.notifier);
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      ref.read(poketmonPaginationProvider.notifier).state++;
    }

    if (_controller.position.pixels == 0) {
      ref.read(scrollToUpperProvider.notifier).state = true;
    } else {
      ref.read(scrollToUpperProvider.notifier).state = false;
    }

    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      srcollProvider.state = false;
    }

    if (_controller.position.userScrollDirection == ScrollDirection.forward) {
      srcollProvider.state = true;
    }
  }
}
