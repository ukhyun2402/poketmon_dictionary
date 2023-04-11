import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketmon_dictionary/config/constant.dart';
import 'package:poketmon_dictionary/config/router.dart';
import 'package:poketmon_dictionary/config/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poketmon_dictionary/model/pokemon_detail.dart';
import 'package:poketmon_dictionary/model/pokemon.dart';
import 'package:poketmon_dictionary/model/pokemon_type.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(PokemonAdapter());
  Hive.registerAdapter(PokemonDetailAdapter());
  Hive.registerAdapter(PokemonTypeAdapter());

  await Hive.openBox<int>(SETTINGS);
  await Hive.openBox<Pokemon>(POKEMON_BOX);
  await Hive.openLazyBox<PokemonDetail>(POKEMON_DETAIL_BOX);

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  runApp(const ProviderScope(child: HomeScreen()));
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: pokdexTheme,
      routerConfig: router,
    );
  }
}
