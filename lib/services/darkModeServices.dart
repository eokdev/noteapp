// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkModeNotifier extends StateNotifier<bool> {
  late SharedPreferences pre;

  Future _init() async {
    pre = await SharedPreferences.getInstance();
    var darkMode = pre.getBool("darkMode");
    state = darkMode ?? false;
  }

  DarkModeNotifier() : super(false) {
    _init();
  }

  void toggle() async {
    state = !state;
    pre.setBool("darkMode", state);
  }
}

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>(
  (ref) => DarkModeNotifier(),
);
