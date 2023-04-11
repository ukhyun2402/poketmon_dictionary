import 'package:html/parser.dart' show parse;
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketmon_dictionary/model/pokemon_detail.dart';
import 'package:poketmon_dictionary/model/poketmon.dart';

final List<Poketmon> _poketmons = [];

final poketmonPaginationProvider = StateProvider<int>((ref) {
  return 1;
});

final poketmonsProvider =
    StateProvider.family<List<Poketmon>, int>((ref, pageIndex) {
  final poketmonResponse = ref.watch(poketmonFetchProvider(pageIndex));
  poketmonResponse.whenData((value) {
    final parsedHtml = parse(value.data).querySelectorAll('li');
    for (var html in parsedHtml) {
      _poketmons.add(Poketmon.fromHtml(html));
    }
  });
  return [..._poketmons];
});

final poketmonFetchProvider =
    FutureProvider.family<Response, int>((ref, page) async {
  final option = BaseOptions(
    baseUrl: 'https://pokemonkorea.co.kr/ajax/pokedex',
    contentType:
        "multipart/form-data; boundary=----WebKitFormBoundaryyxBrC3dBGiBRbzGk",
    headers: {
      'Content-Length': 925,
      'Content-Type':
          'multipart/form-data; boundary=----WebKitFormBoundaryyxBrC3dBGiBRbzGk',
      'Cookie': 'PHPSESSID=4a0vgqjtav5r5rpopo6cr4hjng;',
      'Host': 'pokemonkorea.co.kr'
    },
  );
  final dio = ref.read(dioProvider(option));
  var formData = {
    'mode': 'load_more',
    'word': '',
    'characters': '',
    'pn': page,
    'area': '',
    'snumber': 1,
    'snumber2': 1008,
    'sortselval': 'number asc,number_count asc',
    'typestr': '',
  };
  final response = await dio.post('', data: FormData.fromMap(formData));
  return response;
});

final pokemonDetailFetchProvider =
    FutureProvider.autoDispose.family<PokemonDetail, int>((ref, pokeId) async {
  final option = BaseOptions(
      baseUrl: 'https://pokemonkorea.co.kr/pokedex/view/',
      headers: {
        'Cookie': 'PHPSESSID=4a0vgqjtav5r5rpopo6cr4hjng;',
        'Host': 'pokemonkorea.co.kr',
        'Referer':
            'https://pokemonkorea.co.kr/pokedex/view/1?word=&characters=&area=&snumber=1&snumber2=1008&typetextcs=&sortselval=number%20asc,number_count%20asc',
      });
  final dio = ref.read(
    dioProvider(option),
  );
  final resposne = await dio.get('/$pokeId');
  return PokemonDetail.fromHTML(parse(resposne.data).body!);
});

final dioProvider = Provider.family<Dio, BaseOptions>((ref, option) {
  return Dio(option);
});
