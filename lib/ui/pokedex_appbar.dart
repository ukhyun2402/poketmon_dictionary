import 'package:flutter/material.dart';

class PokedexAppbar extends StatelessWidget with PreferredSizeWidget {
  const PokedexAppbar({
    super.key,
    required this.appbarVisible,
    required this.atTop,
  });

  final bool appbarVisible;
  final bool atTop;
  final double appBarHeight = 50;

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(20, appBarHeight),
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 30),
          height: appbarVisible ? appBarHeight : 0,
          child: Align(
            alignment: Alignment.topLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: MediaQuery.of(context).size.width * (atTop ? 1 : 0.4),
              height: appBarHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ],
                borderRadius: atTop
                    ? null
                    : const BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/poke_ball.png',
                    height: appBarHeight - 10,
                  ),
                  const Text("Pokedex")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
