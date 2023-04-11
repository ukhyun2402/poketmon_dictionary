import 'package:html/dom.dart';
import 'package:poketmon_dictionary/model/pokemon_type.dart';
import 'package:hive/hive.dart';

part 'poketmon.g.dart';

@HiveType(typeId: 0)
class Pokemon {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late int id;
  @HiveField(2)
  late int pokemonId;
  @HiveField(3)
  late String imageUrl;
  @HiveField(4)
  late String? brief;
  @HiveField(5)
  late List<PokemonType> types;

  Pokemon(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.types});

  Pokemon.fromHtml(Element li) {
    imageUrl = li.querySelector('img')?.attributes['src'] ?? '';
    id = int.parse(li.id.split('_')[1]);
    pokemonId = int.parse(
        li.querySelector('.bx-txt h3 p')?.innerHtml.split('.')[1] ?? '0');
    name = li.querySelector('h3')!.text.split(' ')[1];
    types = li.querySelectorAll('.bx-txt span').map((e) {
      switch (e.text) {
        case '불꽃':
          return PokemonType.fire;
        case '물':
          return PokemonType.water;
        case '전기':
          return PokemonType.electric;
        case '풀':
          return PokemonType.grass;
        case '얼음':
          return PokemonType.ice;
        case '격투':
          return PokemonType.fighting;
        case '독':
          return PokemonType.poison;
        case '땅':
          return PokemonType.ground;
        case '비행':
          return PokemonType.flying;
        case '에스퍼':
          return PokemonType.psychic;
        case '벌레':
          return PokemonType.bug;
        case '바위':
          return PokemonType.rock;
        case '고스트':
          return PokemonType.ghost;
        case '드래곤':
          return PokemonType.dragon;
        case '악':
          return PokemonType.dark;
        case '강철':
          return PokemonType.steel;
        case '페어리':
          return PokemonType.fairy;
        default:
          return PokemonType.normal;
      }
    }).toList();
    brief = li.querySelector('.bx-txt > p')?.text ?? '';
  }

  @override
  String toString() {
    return name;
  }
}
