enum PoketmonType {
  normal(0xFFA8A77A, 0xFFd3d2bb),
  fire(0xFFEE8130, 0xFFffc097),
  water(0xFF6390F0, 0xFFb9c6f8),
  electric(0xFFF7D02C, 0xFFffe79d),
  grass(0xFF7AC74C, 0xFFc0e4a6),
  ice(0xFF96D9D6, 0xFFccecea),
  fighting(0xFFC22E28, 0xffec9b8d),
  poison(0xFFA33EA1, 0xffd4a0d0),
  ground(0xFFE2BF65, 0xfff4deb2),
  flying(0xFFA98FF3, 0xffd6c6fa),
  psychic(0xFFF95587, 0xffffb0c1),
  bug(0xFFA6B91A, 0xffd7db95),
  rock(0xFFB6A136, 0xffdfcf9b),
  ghost(0xFF735797, 0xffb8a8ca),
  dragon(0xFF6F35FC, 0xffc49cff),
  dark(0xFF705746, 0xffb6a79e),
  steel(0xFFB7B7CE, 0xffdbdae6),
  fairy(0xFFD685AD, 0xffecc2d5);

  const PoketmonType(this.color, this.backgroundColor);
  final int color;
  final int backgroundColor;
}
