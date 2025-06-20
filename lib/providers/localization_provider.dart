import 'package:flutter/material.dart';

import '../common/app_constants.dart';
import '../common/app_prefs.dart';

class LocalizationProvider extends ChangeNotifier {
  String appLocalization = 'en';

  Future<void> changeLocalization() async {
    if (appLocalization == 'en') {
      appLocalization = 'ar';
    } else {
      appLocalization = 'en';
    }
    localizationSetBool();
    notifyListeners();
  }

  Future<void> changeLocalizationToEnglish() async {
    appLocalization = 'en';
    localizationSetBool();
    notifyListeners();
  }

  Future<void> changeLocalizationToArabic() async {
    appLocalization = 'ar';
    localizationSetBool();
    notifyListeners();
  }

  //caching localization(shared preference) localizationSetBool
  Future<void> localizationSetBool() async {
    await AppPrefs.localizationSetBool(
        AppConstants.localizationKey, appLocalization == 'en' ? true : false);
  }

//caching localization(shared preference) localizationGetBool
  Future<void> localizationGetBool() async {
    bool? localizationGetBool =
        AppPrefs.localizationGetBool(AppConstants.localizationKey);
    if (localizationGetBool == true) {
      appLocalization = 'en';
    } else if(localizationGetBool == false) {
      appLocalization = 'ar';
    }else{
      appLocalization = 'en';
    }
  }
}
