import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:poketmon_dictionary/model/poketmon.dart';

class PoketmonTile extends StatelessWidget {
  final Poketmon poketmon;
  const PoketmonTile({super.key, required this.poketmon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/details', extra: poketmon),
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: poketmon.types.isEmpty
                  ? Colors.white
                  : Color(poketmon.types[0].backgroundColor),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(2, 4))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Container(
                  // margin between circle container and pokemon image
                  margin: const EdgeInsets.all(8),
                  child: Image.network(
                    poketmon.imageUrl,
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
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${poketmon.pokemonId.toString().padLeft(4, '0')}",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      poketmon.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    if (poketmon.brief!.isNotEmpty) Text("${poketmon.brief}"),
                    Row(
                      children: [
                        for (var type in poketmon.types)
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0, top: 8),
                            child: CircleAvatar(
                              backgroundColor: Color(type.color),
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                child: Image.asset(
                                  "assets/images/type-icons/${type.name}.png",
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
