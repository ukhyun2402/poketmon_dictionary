import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart';

class Poketmon {
  late String name;
  late int id;
  late String imageUrl;
  late String? brief;
  late List<String> types;

  Poketmon(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.types});

  Poketmon.fromHtml(Element li) {
    imageUrl = li.querySelector('img')?.attributes['src'] ?? '';
    id = int.parse(li.id.split('_')[1]);
    name = li.querySelector('h3')!.text.split(' ')[1];
    types = li.querySelectorAll('.bx-txt span').map((e) => e.text).toList();
    brief = li.querySelector('.bx-txt > p')?.text ?? '';
  }
}
