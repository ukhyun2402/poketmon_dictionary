import 'package:flutter/material.dart';
import 'package:poketmon_dictionary/model/pokemon_type.dart';

class PokemonDetailGridTile extends StatelessWidget {
  PokemonDetailGridTile(
      {super.key,
      required this.title,
      required this.content,
      this.position,
      required this.backgroundColor,
      this.imageSize = 0.06});

  final String title;
  final Color backgroundColor;
  final List<dynamic> content;
  final CircularRadiusPosition? position;
  final double circularValue = 16;
  double imageSize = 0.06;

  @override
  Widget build(BuildContext context) {
    late BorderRadius? border;

    switch (position) {
      case CircularRadiusPosition.bottomLeft:
        border = BorderRadius.only(bottomLeft: Radius.circular(circularValue));
        break;
      case CircularRadiusPosition.bottomRight:
        border = BorderRadius.only(bottomRight: Radius.circular(circularValue));
        break;
      case CircularRadiusPosition.topLeft:
        border = BorderRadius.only(topLeft: Radius.circular(circularValue));
        break;
      case CircularRadiusPosition.topRight:
        border = BorderRadius.only(topRight: Radius.circular(circularValue));
        break;
      default:
        border = null;
        break;
    }
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor.withOpacity(.4), borderRadius: border),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: border,
            ),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (title == '타입')
                    for (var c in content)
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * imageSize,
                        backgroundColor: Color((c as PokemonType).color),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/type-icons/${(c).name}.png",
                          ),
                        ),
                      )
                  else if (title == '성별')
                    for (var c in content)
                      if ((c as String).contains('icon-man'))
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * imageSize,
                          backgroundColor: Colors.blue.withOpacity(.2),
                          child: const Icon(
                            Icons.male,
                            color: Colors.blue,
                          ),
                        )
                      else if (c.contains('icon-woman'))
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * imageSize,
                          backgroundColor: Colors.pink.withOpacity(.2),
                          child: const Icon(
                            Icons.female,
                            color: Colors.pink,
                          ),
                        )
                      else
                        const Text("정보 없음")
                  else
                    for (var c in content) Text(c.toString())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum CircularRadiusPosition { topLeft, topRight, bottomLeft, bottomRight }
