import 'package:flutter/material.dart';
import 'package:news_app/common/app_colors.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/providers/localization_provider.dart';
import 'package:news_app/views/categories_view.dart';
import 'package:news_app/views/category_details_view.dart';
import 'package:news_app/views/drawer_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool showCategoryDetails = true;
  CategoryType? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key =GlobalKey();
    return Scaffold(
      key: key,
        drawer: SafeArea(
          child: Drawer(
            shape: const RoundedRectangleBorder(),
            backgroundColor: AppColors.mainColorDark,
            child: DrawerView(
              goToHome: () {
                key.currentState!.closeDrawer();
                selectedCategory = null;
                setState(() {});
              },
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            selectedCategory != null
                ? selectedCategory!.getName(
                    context.watch<LocalizationProvider>().appLocalization ==
                        'ar')
                : context.getLocalization().home,
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
          actions: [
            InkResponse(
              onTap: () {},
              //TODO:search logic
              radius: 10,
              borderRadius: BorderRadius.circular(20),
              splashColor: context.getTextTheme().labelMedium!.color,
              child: const Icon(Icons.search_rounded),
            )
          ],
        ),
        body: selectedCategory != null
            ? const CategoryDetailsView()
            : CategoriesView(
                onCategorySelected: (p0) {
                  selectedCategory = p0;
                  setState(() {});
                },
              ));
  }
}
