import 'package:html/dom.dart';

class PokemonDetail {
  late Set<String> descriptions;
  late String? height;
  late String? category;
  late List<String> genders;
  late String? weight;
  late String? character;

  PokemonDetail({
    required this.descriptions,
    required this.height,
    required this.category,
    required this.genders,
    required this.weight,
    required this.character,
  });

  PokemonDetail.fromHTML(Element el) {
    descriptions =
        el.querySelectorAll('.para.descript').map((e) => e.innerHtml).toSet();
    height = el.querySelectorAll('.col-4')[1].querySelector('p]')?.innerHtml;
    category = el.querySelectorAll('.col-4')[2].querySelector('p')?.innerHtml;
    genders = el
        .querySelector('.col-4.pl-0')!
        .querySelectorAll('i')
        .map((element) => element.className)
        .toList();
    weight = el.querySelectorAll('.col-4')[4].querySelector('p')?.innerHtml;
    character = el
        .querySelectorAll('.col-4')[5]
        .querySelector('div')
        ?.text
        .trim()
        .split(' ')[0];
  }
  @override
  String toString() {
    return "category: ${this.category}, description: ${this.descriptions.join(',')}, height: ${this.height}, genders: ${this.genders.join(',')}, weight: ${this.weight}, character: ${this.character}";
  }
}
