import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:poketmon_dictionary/model/poketmon.dart';
import 'package:poketmon_dictionary/service/poketmon_service.dart';
import 'package:poketmon_dictionary/ui/pokemon_gridtile.dart';

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
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 24, left: 16, right: 16),
              decoration: BoxDecoration(
                  color: Color(pokemon.types[0].backgroundColor),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(24))),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48),
                      color: Colors.white),
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
            ),
          ),
          pokemonDetail.when(
            data: (detailState) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          crossAxisCount: 3,
                        ),
                        children: [
                          PokemonDetailGridTile(
                            title: "타입",
                            content: pokemon.types,
                            position: CircularRadiusPosition.topLeft,
                            backgroundColor:
                                Color(pokemon.types[0].backgroundColor),
                          ),
                          PokemonDetailGridTile(
                            title: "키",
                            content: [detailState.height],
                            backgroundColor:
                                Color(pokemon.types[0].backgroundColor),
                          ),
                          PokemonDetailGridTile(
                            title: "분류",
                            content: [detailState.category],
                            position: CircularRadiusPosition.topRight,
                            backgroundColor:
                                Color(pokemon.types[0].backgroundColor),
                          ),
                          PokemonDetailGridTile(
                            title: "성별",
                            content: detailState.genders,
                            position: CircularRadiusPosition.bottomLeft,
                            backgroundColor:
                                Color(pokemon.types[0].backgroundColor),
                          ),
                          PokemonDetailGridTile(
                            title: "몸무게",
                            content: [detailState.weight],
                            backgroundColor:
                                Color(pokemon.types[0].backgroundColor),
                          ),
                          PokemonDetailGridTile(
                            title: "특성",
                            content: [detailState.character],
                            position: CircularRadiusPosition.bottomRight,
                            backgroundColor:
                                Color(pokemon.types[0].backgroundColor),
                          ),
                        ],
                      ),
                    ),
                    for (String i in detailState.descriptions)
                      if (i.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 0),
                          child: Card(
                            color: Color(pokemon.types[0].backgroundColor),
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
              child: Center(child: Text("Occur Some error\n ${s.toString()}")),
            ),
            loading: () => const SliverToBoxAdapter(),
          ),
        ],
      ),
    );
  }
}
