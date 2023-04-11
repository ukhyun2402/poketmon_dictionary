import 'package:flutter/material.dart';
import 'package:poketmon_dictionary/model/pokemon_detail.dart';
import 'package:poketmon_dictionary/model/pokemon.dart';
import 'package:poketmon_dictionary/ui/pokemon_gridtile.dart';

class DetailGridView extends StatelessWidget {
  DetailGridView(
      {super.key,
      required this.pokemon,
      required this.detailState,
      this.imageSize = 0.06});

  final Pokemon pokemon;
  final PokemonDetail detailState;
  double imageSize;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = pokemon.types.isEmpty
        ? const Color.fromARGB(255, 220, 220, 220)
        : Color(pokemon.types[0].backgroundColor);
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        crossAxisCount: 3,
      ),
      children: [
        PokemonDetailGridTile(
          title: "타입",
          content: pokemon.types,
          position: CircularRadiusPosition.topLeft,
          backgroundColor: backgroundColor,
          imageSize: imageSize,
        ),
        PokemonDetailGridTile(
          title: "키",
          content: [detailState.height],
          backgroundColor: backgroundColor,
        ),
        PokemonDetailGridTile(
          title: "분류",
          content: [detailState.category],
          position: CircularRadiusPosition.topRight,
          backgroundColor: backgroundColor,
        ),
        PokemonDetailGridTile(
          title: "성별",
          content: detailState.genders,
          position: CircularRadiusPosition.bottomLeft,
          backgroundColor: backgroundColor,
          imageSize: imageSize,
        ),
        PokemonDetailGridTile(
          title: "몸무게",
          content: [detailState.weight],
          backgroundColor: backgroundColor,
        ),
        PokemonDetailGridTile(
          title: "특성",
          content: [detailState.character],
          position: CircularRadiusPosition.bottomRight,
          backgroundColor: backgroundColor,
        ),
      ],
    );
  }
}
