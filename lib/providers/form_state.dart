import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class AppState with ChangeNotifier {
  bool darkMode;
  AppState(this.darkMode);
  bool _passwordView = false;
  bool get passwordView => _passwordView;

  set passwordView(bool passwordView) {
    _passwordView = passwordView;
    notifyListeners();
  }

  darkModeset() async {
    final Box settings = await Hive.openBox('settings');
    settings.put('isdark', !darkMode);
    darkMode = !darkMode;
    notifyListeners();
  }
}
