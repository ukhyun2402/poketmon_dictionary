import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poketmon_dictionary/model/pokemon_detail.dart';
import 'package:poketmon_dictionary/service/poketmon_service.dart';
import 'package:html/parser.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = ref.watch(pokemonDetailProvider(1));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: p.when(
          data: (value) {
            return Text(
                PokemonDetail.fromHTML(parse(value.data).querySelector('#ct')!)
                    .toString());
          },
          error: (e, s) => Text("$e"),
          loading: () => Text("loading"),
        ),
      ),
    );
  }
}
