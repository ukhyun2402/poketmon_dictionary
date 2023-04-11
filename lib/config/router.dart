import 'package:go_router/go_router.dart';
import 'package:poketmon_dictionary/model/pokemon.dart';
import 'package:poketmon_dictionary/ui/screen/detail/detail_screen.dart';
import 'package:poketmon_dictionary/ui/screen/main_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
      routes: [
        GoRoute(
          path: 'details',
          builder: (context, state) => DetailScreen(
            pokemon: state.extra as Pokemon,
          ),
        )
      ],
    ),
  ],
);
