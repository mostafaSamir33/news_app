import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/providers/localization_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/app_colors.dart';
import '../../../common/custom_text_styles.dart';

class CustomDropDownMenuLocalization extends StatelessWidget {
  const CustomDropDownMenuLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: DropdownMenu<String>(
        menuHeight: context.getScreenSize().height,
        width: context.getScreenSize().width * 0.76 - 30,
        hintText: context.watch<LocalizationProvider>().appLocalization == 'en'
            ? context.getLocalization().english
            : context.getLocalization().arabic,
        onSelected: (value) {
          if (value == 'en') {
            context.read<LocalizationProvider>().changeLocalizationToEnglish();
          } else if (value == 'ar') {
            context.read<LocalizationProvider>().changeLocalizationToArabic();
          }
        },
        trailingIcon: const Icon(
          Icons.arrow_drop_down_rounded,
          size: 40,
          color: AppColors.mainColorLight,
        ),
        selectedTrailingIcon: const Icon(
          Icons.arrow_drop_up_rounded,
          size: 40,
          color: AppColors.mainColorLight,
        ),
        textStyle: CustomTextStyles.style20w500White,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: CustomTextStyles.style20w500White,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.mainColorLight, width: 1.5),
          ),
        ),
        menuStyle: MenuStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          backgroundColor: const WidgetStatePropertyAll(AppColors.mainColorLight),
          shadowColor: const WidgetStatePropertyAll(Colors.black),
          // surfaceTintColor: WidgetStatePropertyAll(Theme.of(context).splashColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.mainColorLight, width: 1.5)),
          ),
        ),
        dropdownMenuEntries: [
          DropdownMenuEntry(
            value: 'en',
            label: context.getLocalization().english,
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(AppColors.grey),
              foregroundColor: const WidgetStatePropertyAll(AppColors.mainColorDark),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              textStyle: const WidgetStatePropertyAll(
                CustomTextStyles.style20w500Black,
              ),
            ),
          ),
          DropdownMenuEntry(
            value: 'ar',
            label: context.getLocalization().arabic,
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(AppColors.grey),
              foregroundColor: const WidgetStatePropertyAll(AppColors.mainColorDark),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              textStyle: const WidgetStatePropertyAll(
                CustomTextStyles.style20w500Black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
