import 'package:flutter/material.dart';

import '../common/app_constants.dart';
import '../common/app_prefs.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  Future<void> changeAppTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    themeSetBool();
    notifyListeners();
  }

  Future<void> changeAppThemeToLight() async {
    themeMode = ThemeMode.light;
    themeSetBool();
    notifyListeners();
  }

  Future<void> changeAppThemeToDark() async {
    themeMode = ThemeMode.dark;
    themeSetBool();
    notifyListeners();
  }

  //caching theme(shared preference) themeSetBool
  Future<void> themeSetBool()async{
    await AppPrefs.themeSetBool(
        AppConstants.themeKey, themeMode == ThemeMode.light ? true : false);
  }

//caching theme(shared preference) themeGetBool
  Future<void> themeGetBool() async {
    bool? themeGetBool = AppPrefs.themeGetBool(AppConstants.themeKey);
    if(themeGetBool==true){
      themeMode=ThemeMode.light;
    }else if(themeGetBool==false){
      themeMode=ThemeMode.dark;
    }else{
      themeMode=ThemeMode.light;
    }
  }
}
