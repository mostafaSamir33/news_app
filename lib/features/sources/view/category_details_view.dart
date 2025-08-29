import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/features/articles/view_model/articles_view_model_provider.dart';
import 'package:news_app/features/articles/view_model/cubit/articles_cubit.dart';
import 'package:news_app/features/sources/view_model/cubit/sources_cubit.dart';
import 'package:news_app/features/sources/view_model/cubit/sources_cubit_state.dart';
import 'package:provider/provider.dart';

import '../../articles/view/articles_tab_content.dart';
import '../../categories/model/category.dart';

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
    return BlocProvider(
      create: (context) => SourcesCubit()
        ..getSources(
            widget.selectedCategory?.name ?? CategoryType.general.name),
      child: BlocBuilder<SourcesCubit, SourcesCubitState>(
        builder: (context, state) {
          controller = TabController(
              length: state is GetSourcesSuccess ? state.sources.length : 0,
              vsync: this);
          if (state is GetSourcesLoading || state is SourcesCubitInitialState) {
            return Center(
              child: CircularProgressIndicator(
                color: context.getTextTheme().titleSmall!.color,
              ),
            );
          } else if (state is GetSourcesFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: context.getTextTheme().labelMedium,
                textAlign: TextAlign.center,
              ),
            );
          } else if (state is GetSourcesEmptyList) {
            return Center(
              child: Text(
                'There is no news',
                style: context
                    .getTextTheme()
                    .labelMedium
                    ?.copyWith(color: Colors.red),
              ),
            );
          } else {
            if (state is! GetSourcesSuccess) {
              return const SizedBox.shrink();
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
                    state.sources.length,
                    (index) => Tab(
                      text: state.sources[index].name,
                    ),
                  ),
                ),
                BlocProvider(
                  create: (BuildContext context) => ArticlesCubit(),
                  child: Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: List.generate(
                          state.sources.length,
                          (tabIndex) => TabContent(
                              sourceId: state.sources[tabIndex].id!)),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
