import 'package:html/parser.dart' show parse;

class Poketmon {
  late String name;
  late int id;
  late String imageUrl;

  Poketmon({required this.name, required this.id, required this.imageUrl});

  Poketmon.fromHtml(String rawHtml) {
    var document = parse(rawHtml);
    //TODO: parse data from html and make object
    name = "dada";
    id = 1;
    imageUrl = 'dasdas';
  }
}
