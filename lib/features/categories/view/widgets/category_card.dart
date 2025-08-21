import 'package:flutter/material.dart';
import 'package:news_app/common/app_colors.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/features/categories/model/category.dart';
import 'package:news_app/providers/localization_provider.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final CategoryType categoryType;
  final int index;
  final void Function(CategoryType) onCategorySelected;

  const CategoryCard(
      {super.key, required this.categoryType, required this.index, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    String appLocalization =
        context.watch<LocalizationProvider>().appLocalization;
    return SizedBox(
      height: context.getScreenSize().height * 0.28,
      width: context.getScreenSize().width,
      child: GestureDetector(
        onTap: () => onCategorySelected(categoryType),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: context.getTextTheme().labelMedium!.color,
              borderRadius: BorderRadius.circular(24)),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: index.isOdd && appLocalization == 'en'
                    ? 0
                    : index.isEven && appLocalization == 'ar'
                        ? 0
                        : null,
                left: index.isEven && appLocalization == 'en'
                    ? 0
                    : index.isOdd && appLocalization == 'ar'
                        ? 0
                        : null,
                child: Transform.flip(
                  flipX: appLocalization == 'ar',
                  child: ClipRRect(
                    borderRadius: BorderRadius.horizontal(
                        left: index.isEven ? const Radius.circular(24) : Radius.zero,
                        right: index.isOdd ? const Radius.circular(24) : Radius.zero),
                    child: Image.asset(
                      categoryType.getCategoryImage(),
                      fit: BoxFit.cover,
                      height: context.getScreenSize().height * 0.28,
                      width: index.isOdd
                          ? context.getScreenSize().width * 0.5
                          : null,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: index.isOdd && appLocalization == 'ar'
                    ? 0
                    : index.isEven && appLocalization == 'en'
                        ? 0
                        : null,
                left: index.isEven && appLocalization == 'ar'
                    ? 0
                    : index.isOdd && appLocalization == 'en'
                        ? 0
                        : null,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: index.isEven && appLocalization == 'en'
                          ? 20
                          : index.isOdd && appLocalization == 'ar'
                              ? 20
                              : 0,
                      left: index.isOdd && appLocalization == 'en'
                          ? 20
                          : index.isEven && appLocalization == 'ar'
                              ? 20
                              : 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        categoryType.getName(context
                                .watch<LocalizationProvider>()
                                .appLocalization ==
                            'ar'),
                        style: context.getTextTheme().displaySmall!.copyWith(
                            fontSize: 28,
                            color:
                                context.getThemeData().scaffoldBackgroundColor),
                      ),
                      Container(
                        width: context.getScreenSize().width * 0.433,
                        decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(84)),
                        child: Row(
                          textDirection: index.isEven && appLocalization == 'en'
                              ? TextDirection.ltr
                              : index.isEven && appLocalization == 'ar'
                                  ? TextDirection.rtl
                                  : index.isOdd && appLocalization == 'en'
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, top: 10, bottom: 10, right: 10),
                              child: Text(
                                context.getLocalization().viewAll,
                                style: context.getTextTheme().labelMedium,
                              ),
                            ),
                            CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  context.getThemeData().scaffoldBackgroundColor,
                              foregroundColor:
                                  context.getTextTheme().labelMedium!.color,
                              child: Icon(
                                index.isEven
                                    ? Icons.arrow_forward_ios_rounded
                                    : Icons.arrow_back_ios_rounded,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
