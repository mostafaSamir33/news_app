import 'package:news_app/common/app_assets.dart';

enum CategoryType {
  general,
  business,
  sports,
  technology,
  entertainment,
  health,
  science;

  String getCategoryImage() {
    switch (this) {
      case general:
        return AppAssets.general;
      case business:
        return AppAssets.business;
      case sports:
        return AppAssets.sport;
      case technology:
        return AppAssets.technology;
      case entertainment:
        return AppAssets.entertainment;
      case health:
        return AppAssets.health;
      case science:
        return AppAssets.science;
    }
  }

  String getName(bool isArabic) {
    if (isArabic && name == general.name) {
      return 'عام';
    } else if (isArabic && name == business.name) {
      return 'عمل';
    } else if (isArabic && name == sports.name) {
      return 'رياضة';
    } else if (isArabic && name == technology.name) {
      return 'تكنولوجيا';
    } else if (isArabic && name == entertainment.name) {
      return 'ترفيه';
    } else if (isArabic && name == health.name) {
      return 'صحة';
    } else if (isArabic && name == science.name) {
      return 'علوم';
    } else {
      return name.substring(0, 1).toUpperCase() + name.substring(1);
    }
  }
}
