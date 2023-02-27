import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final poketmonProvider = FutureProvider<Response>((ref) async {
  final dio = ref.read(dioProvider);
  const formData = {
    'mode': 'load_more',
    'word': '',
    'characters': '',
    'pn': 1,
    'area': '',
    'snumber': 1,
    'snumber2': 1008,
    'sortselval': 'number asc,number_count asc',
    'typestr': '',
  };
  final response = await dio.post('', data: FormData.fromMap(formData));
  return response;
});

final dioProvider = Provider<Dio>((ref) {
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
  return Dio(option);
});
