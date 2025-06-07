import 'package:flutter/material.dart';
import 'package:news_app/common/app_colors.dart';
import 'package:news_app/common/custom_text_styles.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomDropDownMenuTheme extends StatelessWidget {
  const CustomDropDownMenuTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: DropdownMenu<ThemeMode>(
        menuHeight: context.getScreenSize().height,
        width: context.getScreenSize().width * 0.76 - 30,
        hintText: context.watch<ThemeProvider>().themeMode == ThemeMode.light
            ? context.getLocalization().light
            : context.getLocalization().dark,
        onSelected: (value) {
          if (value == ThemeMode.light) {
            context.read<ThemeProvider>().changeAppThemeToLight();
          } else if (value == ThemeMode.dark) {
            context.read<ThemeProvider>().changeAppThemeToDark();
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
            value: ThemeMode.light,
            label: context.getLocalization().light,
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
            value: ThemeMode.dark,
            label: context.getLocalization().dark,
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
