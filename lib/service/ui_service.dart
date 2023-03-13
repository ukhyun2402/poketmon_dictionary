import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final scrollDirectionProvider = StateProvider<bool>((ref) {
  return true;
});

final scrollToUpperProvider = StateProvider<bool>((ref) => true);
