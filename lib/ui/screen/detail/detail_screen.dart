import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:poketmon_dictionary/model/poketmon.dart';
import 'package:poketmon_dictionary/service/poketmon_service.dart';
import 'package:poketmon_dictionary/ui/screen/detail/components/detail_gridview.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.pokemon});
  final Poketmon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonDetail = ref.watch(pokemonDetailFetchProvider(pokemon.id));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color(pokemon.types[0].backgroundColor),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => context.go('/'),
            ),
            title: Align(
              alignment: Alignment.centerRight,
              child: Text("#${pokemon.pokemonId} ${pokemon.name}"),
            ),
          ),
          SliverLayoutBuilder(builder: (context, constraint) {
            if (constraint.crossAxisExtent < 600) {
              return SliverToBoxAdapter(
                  child: PokemonDeatilImage(pokemon: pokemon));
            } else {
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                delegate: SliverChildListDelegate(
                  [
                    PokemonDeatilImage(pokemon: pokemon),
                    pokemonDetail.maybeWhen(data: (detailState) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Color(pokemon.types[0].backgroundColor)
                                .withOpacity(0.4),
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: DetailGridView(
                              pokemon: pokemon,
                              detailState: detailState,
                              imageSize: 0.03,
                            ),
                          ),
                        ),
                      );
                    }, orElse: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })
                  ],
                ),
              );
            }
          }),
          SliverLayoutBuilder(
            builder: (context, constraint) {
              if (constraint.crossAxisExtent < 600) {
                return pokemonDetail.when(
                  data: (detailState) {
                    return SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: DetailGridView(
                              pokemon: pokemon,
                              detailState: detailState,
                            ),
                          ),
                          for (String i in detailState.descriptions)
                            if (i.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 0),
                                child: Card(
                                  color:
                                      Color(pokemon.types[0].backgroundColor),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            i,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                        ],
                      ),
                    );
                  },
                  error: (err, s) => SliverToBoxAdapter(
                    child: Center(
                        child: Text("Occur Some error\n ${s.toString()}")),
                  ),
                  loading: () => const SliverToBoxAdapter(),
                );
              } else {
                return pokemonDetail.maybeWhen(
                    data: (detailState) {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          for (String i in detailState.descriptions)
                            if (i.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 0),
                                child: Card(
                                  color:
                                      Color(pokemon.types[0].backgroundColor),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            i,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                        ]),
                      );
                    },
                    orElse: () =>
                        const SliverToBoxAdapter(child: Text("Loading...")));
              }
            },
          )
        ],
      ),
    );
  }
}

class PokemonDeatilImage extends StatelessWidget {
  const PokemonDeatilImage({
    super.key,
    required this.pokemon,
  });

  final Poketmon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 24, left: 16, right: 16),
      decoration: BoxDecoration(
          color: Color(pokemon.types[0].backgroundColor),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(36))),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48), color: Colors.white),
          child: Image.network(
            pokemon.imageUrl,
            fit: BoxFit.fitHeight,
            loadingBuilder: (context, child, loadingProgess) {
              if (loadingProgess == null) {
                return child;
              }
              return Padding(
                padding: const EdgeInsets.all(36.0),
                child: Lottie.asset(
                  'assets/lotties/pokeball_loading.json',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
