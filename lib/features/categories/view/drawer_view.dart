import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/common/app_assets.dart';
import 'package:news_app/common/app_colors.dart';
import 'package:news_app/common/custom_text_styles.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/features/categories/view/custom_drop_down_menu_theme.dart';

import 'custom_drop_down_menu_localization.dart';

class DrawerView extends StatelessWidget {
  final void Function() goToHome;
  const DrawerView({super.key, required this.goToHome});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: context.getScreenSize().height * 0.19,
          decoration: const BoxDecoration(color: AppColors.mainColorLight),
          child: Text(
            context.getLocalization().newsApp,
            style: CustomTextStyles.style24w700Black,
          ),
        ),
        ListTile(
          onTap: () {
            goToHome();
          },
          leading: SvgPicture.asset(
            AppAssets.homeIcon,
            height: 24,
            width: 24,
          ),
          title: Text(
            context.getLocalization().goToHome,
            style: CustomTextStyles.style20w700White,
          ),
        ),
        const Divider(),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.themeIcon,
            height: 24,
            width: 24,
          ),
          title: Text(
            context.getLocalization().theme,
            style: CustomTextStyles.style20w700White,
          ),
        ),
        const CustomDropDownMenuTheme(),
        const Divider(),
        ListTile(
          leading: SvgPicture.asset(
            AppAssets.languageIcon,
            height: 24,
            width: 24,
          ),
          title: Text(
            context.getLocalization().language,
            style: CustomTextStyles.style20w700White,
          ),
        ),
        const CustomDropDownMenuLocalization()
      ],
    );
  }
}
