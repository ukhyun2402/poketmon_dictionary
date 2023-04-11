import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketmon_dictionary/service/poketmon_service.dart';

class PokedexAppbar extends ConsumerStatefulWidget with PreferredSizeWidget {
  const PokedexAppbar({
    super.key,
    required this.appbarVisible,
    required this.atTop,
  });

  final double appBarHeight = 50;
  final bool appbarVisible;
  final bool atTop;

  @override
  PokedexAppbarState createState() => PokedexAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}

class PokedexAppbarState extends ConsumerState<PokedexAppbar> {
  var textFieldActivate = false;
  final _textFieldController = TextEditingController();

  @override
  void initState() {
    _textFieldController.addListener(() {
      ref.read(searchTextProvider.notifier).state = _textFieldController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, widget.appBarHeight),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 30),
        height: widget.appbarVisible ? widget.appBarHeight : 0,
        child: Align(
          alignment: Alignment.topLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: MediaQuery.of(context).size.width,
            height: widget.appBarHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ],
              borderRadius: widget.atTop
                  ? null
                  : const BorderRadius.only(
                      topRight: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/images/poke_ball.png',
                      height: widget.appBarHeight - 10,
                    ),
                    const Text("Pokedex")
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                  ),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      if (widget.appbarVisible && textFieldActivate)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: widget.appBarHeight - 10,
                              child: TextField(
                                controller: _textFieldController,
                                autofocus: true,
                                decoration: const InputDecoration(
                                    label: Text("pokemon"),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24)))),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  textFieldActivate = false;
                                  _textFieldController.clear();
                                });
                              },
                              icon: const Icon(Icons.search_off),
                            ),
                          ],
                        )
                      else if (widget.appbarVisible && !textFieldActivate)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  textFieldActivate = true;
                                });
                              },
                              icon: const Icon(Icons.search),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
