import 'package:flutter/material.dart';
import 'package:poketmon_dictionary/model/pokemon.dart';

class PoketmonTile extends StatelessWidget {
  final Pokemon poketmon;
  const PoketmonTile({super.key, required this.poketmon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey,
      ),
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Stack(children: [
          Image.network(
            poketmon.imageUrl,
            fit: BoxFit.fitHeight,
          ),
          Text("No.${poketmon.id.toString().padLeft(4, '0')} ${poketmon.name}")
        ]),
      ),
    );
  }
}
