import 'package:html/dom.dart';
import 'package:poketmon_dictionary/model/poketmon_type.dart';

class Poketmon {
  late String name;
  late int id;
  late int pokemonId;
  late String imageUrl;
  late String? brief;
  List<PoketmonType> types = [PoketmonType.normal];

  Poketmon(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.types});

  Poketmon.fromHtml(Element li) {
    imageUrl = li.querySelector('img')?.attributes['src'] ?? '';
    id = int.parse(li.id.split('_')[1]);
    pokemonId = int.parse(
        li.querySelector('.bx-txt h3 p')?.innerHtml.split('.')[1] ?? '0');
    name = li.querySelector('h3')!.text.split(' ')[1];
    types = li.querySelectorAll('.bx-txt span').map((e) {
      switch (e.text) {
        case '불꽃':
          return PoketmonType.fire;
        case '물':
          return PoketmonType.water;
        case '전기':
          return PoketmonType.electric;
        case '풀':
          return PoketmonType.grass;
        case '얼음':
          return PoketmonType.ice;
        case '격투':
          return PoketmonType.fighting;
        case '독':
          return PoketmonType.poison;
        case '땅':
          return PoketmonType.ground;
        case '비행':
          return PoketmonType.flying;
        case '에스퍼':
          return PoketmonType.psychic;
        case '벌레':
          return PoketmonType.bug;
        case '바위':
          return PoketmonType.rock;
        case '고스트':
          return PoketmonType.ghost;
        case '드래곤':
          return PoketmonType.dragon;
        case '악':
          return PoketmonType.dark;
        case '강철':
          return PoketmonType.steel;
        case '페어리':
          return PoketmonType.fairy;
        default:
          return PoketmonType.normal;
      }
    }).toList();
    brief = li.querySelector('.bx-txt > p')?.text ?? '';
  }
}
