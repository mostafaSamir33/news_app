import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';

import '../models/category.dart';
import '../widgets/category_card.dart';

class CategoriesView extends StatelessWidget {
  final void Function(CategoryType) onCategorySelected;
  const CategoriesView({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${context.getLocalization().goodMorning}\n${context.getLocalization().hereIsSomeNewsForYou}', //TODO:localization
            style: context.getTextTheme().labelMedium,
          ),
          ...List.generate(
            CategoryType.values.length,
            (index) => CategoryCard(
              categoryType: CategoryType.values[index],
              index: index,
              onCategorySelected: onCategorySelected,
            ),
          )
        ],
      ),
    );
  }
}
