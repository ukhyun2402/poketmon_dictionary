import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketmon_dictionary/service/poketmon_service.dart';
import 'package:poketmon_dictionary/service/ui_service.dart';
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
    _controller = ScrollController()..addListener(scrollControllerEvent);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(() {});
    super.dispose();
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

  void scrollControllerEvent() {
    final srcollProvider = ref.read(scrollDirectionProvider.notifier);
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      ref.read(poketmonPaginationProvider.notifier).state++;
    }

    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      srcollProvider.state = false;
    }

    if (_controller.position.userScrollDirection == ScrollDirection.forward) {
      srcollProvider.state = true;
    }
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarVisible = ref.watch(scrollDirectionProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
        brightness: Brightness.light,
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: Scaffold(
        // appBar: AppBar(title: Consumer(
        //   builder: (context, re, child) {
        //     final appBarisVisible = ref.watch(scrollDirectionProvider);
        //     log(appBarisVisible.toString());
        //     return AnimatedContainer(
        //       duration: const Duration(milliseconds: 200),
        //       height: appBarisVisible ? 0 : 56,
        //       child: Text("hello world"),
        //     );
        //   },
        // )),
        // TODO: hide appbar when scroll down
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              Consumer(builder: ((context, ref, child) {
                final appbarVisible = ref.watch(scrollDirectionProvider);
                log(appbarVisible.toString());
                return SliverAppBar(
                  title: Text("HELLOWORLD"),
                  floating: true,
                  forceElevated: true,
                );
              }))
            ];
          },
          body: const MainScreen(),
        ),
      ),
    );
  }
}
