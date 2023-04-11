import 'dart:developer';

import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'package:poketmon_dictionary/components/poketmon_tile.dart';
import 'package:poketmon_dictionary/config/constant.dart';
import 'package:poketmon_dictionary/service/poketmon_service.dart';
import 'package:poketmon_dictionary/service/ui_service.dart';
import 'package:poketmon_dictionary/ui/pokedex_appbar.dart';
import 'package:hive/hive.dart';

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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => snackbar);
    //==================state==================
    final pokemonPageIndex = ref.watch(pokemonPaginationProvider);
    final pokemonsProviderRef = ref.watch(pokemonsProvider(pokemonPageIndex));
    final appbarVisible = ref.watch(scrollDirectionProvider);
    final atTop = ref.watch(scrollToUpperProvider);
    //==================state==================
    //==================listen state==================
    ref.listen(isLoadingPovider, (previous, next) => snackbar(next));
    //==================listen state==================

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PokedexAppbar(appbarVisible: appbarVisible, atTop: atTop),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return ListView.builder(
              shrinkWrap: true,
              controller: _controller,
              itemBuilder: (context, index) {
                // return PoketmonTile(poketmon: pokemonsProviderRef[index]);
                return PoketmonTile(poketmon: pokemonList()[index]);
              },
              itemCount: pokemonList().length,
            );
          } else {
            return GridView.builder(
                shrinkWrap: true,
                controller: _controller,
                itemCount: pokemonsProviderRef.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 1),
                itemBuilder: (context, index) {
                  return PoketmonTile(poketmon: pokemonsProviderRef[index]);
                });
          }
        }),
      ),
    );
  }

  void snackbar(next) {
    if (next) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(days: 365),
          content: Text("포켓몬을 불러오고 있습니다!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
  }

  void scrollControllerEvent() {
    final srcollProvider = ref.read(scrollDirectionProvider.notifier);
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange &&
        ref.watch(searchTextProvider).isEmpty) {
      Hive.box<int>(SETTINGS)
          .put('page', ++ref.read(pokemonPaginationProvider.notifier).state);
      ref.read(isLoadingPovider.notifier).state = true;
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

  List pokemonList() {
    //-----------------------------------------------------------------------state
    final searchText = ref.watch(searchTextProvider);
    final pokemonPageIndex = ref.watch(pokemonPaginationProvider);
    final pokemonsProviderRef = ref.watch(pokemonsProvider(pokemonPageIndex));
    //-----------------------------------------------------------------------state
    if (searchText.isEmpty) {
      return pokemonsProviderRef;
    } else {
      RegExp exp = getRegExp(searchText, RegExpOptions(initialSearch: true));
      return pokemonsProviderRef
          .where((element) => exp.hasMatch(element.name))
          .toList();
    }
  }
}
