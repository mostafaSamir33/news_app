import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/features/articles/view_model/articles_view_model_provider.dart';
import 'package:news_app/features/sources/view_model/sources_view_model_provider.dart';
import 'package:provider/provider.dart';

import '../../categories/model/category.dart';
import '../../articles/view/articles_tab_content.dart';

class CategoryDetailsView extends StatefulWidget {
  final CategoryType? selectedCategory;

  const CategoryDetailsView({super.key, required this.selectedCategory});

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView>
    with TickerProviderStateMixin {
  TabController? controller;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SourcesViewModelProvider()
        ..getSources(
            widget.selectedCategory?.name ?? CategoryType.general.name),
      builder: (context, child) {
        return Consumer<SourcesViewModelProvider>(
          builder: (context, provider, child) {
            controller =
                TabController(length: provider.sources.length, vsync: this);
            if (provider.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: context.getTextTheme().titleSmall!.color,
                ),
              );
            }

            if (provider.errorMessage != null) {
              return Center(
                child: Text(
                  provider.errorMessage!,
                  style: context.getTextTheme().labelMedium,
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (provider.sources.isEmpty == true) {
              return Center(
                child: Text(
                  'There is no news',
                  style: context
                      .getTextTheme()
                      .labelMedium
                      ?.copyWith(color: Colors.red),
                ),
              );
            }

            return Column(
              children: [
                TabBar(
                  controller: controller,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: context.getTextTheme().titleSmall!.color,
                  indicatorPadding: const EdgeInsets.only(bottom: 5),
                  overlayColor: WidgetStatePropertyAll(
                      context.getTextTheme().titleSmall!.color),
                  splashBorderRadius: BorderRadius.circular(20),
                  labelStyle: context.getTextTheme().titleSmall,
                  unselectedLabelStyle: context.getTextTheme().bodySmall,
                  tabs: List.generate(
                    provider.sources.length,
                    (index) => Tab(
                      text: provider.sources[index].name,
                    ),
                  ),
                ),
                ChangeNotifierProvider(
                  create: (BuildContext context) => ArticlesViewModelProvider(),
                  child: Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: List.generate(
                          provider.sources.length,
                          (tabIndex) => TabContent(
                              sourceId: provider.sources[tabIndex].id!)),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
