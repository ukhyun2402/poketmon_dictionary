import 'package:hive/hive.dart';

part 'pokemon_type.g.dart';

@HiveType(typeId: 3)
enum PokemonType {
  @HiveField(0)
  normal(0xFFA8A77A, 0xFFd3d2bb),
  @HiveField(1)
  fire(0xFFEE8130, 0xFFffc097),
  @HiveField(2)
  water(0xFF6390F0, 0xFFb9c6f8),
  @HiveField(3)
  electric(0xFFF7D02C, 0xFFffe79d),
  @HiveField(4)
  grass(0xFF7AC74C, 0xFFc0e4a6),
  @HiveField(5)
  ice(0xFF96D9D6, 0xFFccecea),
  @HiveField(6)
  fighting(0xFFC22E28, 0xffec9b8d),
  @HiveField(7)
  poison(0xFFA33EA1, 0xffd4a0d0),
  @HiveField(8)
  ground(0xFFE2BF65, 0xfff4deb2),
  @HiveField(9)
  flying(0xFFA98FF3, 0xffd6c6fa),
  @HiveField(10)
  psychic(0xFFF95587, 0xffffb0c1),
  @HiveField(11)
  bug(0xFFA6B91A, 0xffd7db95),
  @HiveField(12)
  rock(0xFFB6A136, 0xffdfcf9b),
  @HiveField(13)
  ghost(0xFF735797, 0xffb8a8ca),
  @HiveField(14)
  dragon(0xFF6F35FC, 0xffc49cff),
  @HiveField(15)
  dark(0xFF705746, 0xffb6a79e),
  @HiveField(16)
  steel(0xFFB7B7CE, 0xffdbdae6),
  @HiveField(17)
  fairy(0xFFD685AD, 0xffecc2d5);

  const PokemonType(this.color, this.backgroundColor);
  final int color;
  final int backgroundColor;
}
