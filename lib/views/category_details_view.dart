import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/models/article_response_model.dart';
import 'package:news_app/network/articles_apis.dart';
import 'package:news_app/network/source_apis.dart';
import 'package:news_app/widgets/article_card.dart';

import '../models/category.dart';
import '../models/source_response_model.dart';

class CategoryDetailsView extends StatefulWidget {
  final CategoryType? selectedCategory;

  const CategoryDetailsView({super.key, required this.selectedCategory});

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView>
    with TickerProviderStateMixin {
  int selectedSourceIndex = 0;
  TabController? controller;
  List<SourceModel>? sources;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadSources();
  }

  Future<void> loadSources() async {
    try {
      final result = await SourceApis.getSourcesByCategory(
        widget.selectedCategory?.name ?? CategoryType.general.name,
      );
      sources = result;
      if (mounted) {
        controller = TabController(length: sources?.length ?? 4, vsync: this);
        controller!.addListener(() {
          setState(() {
            selectedSourceIndex = controller!.index;
          });
          log("Selected Index: ${controller!.index}");
        });
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: context.getTextTheme().titleSmall!.color,
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
          style: context.getTextTheme().labelMedium,
        ),
      );
    }

    if (sources?.isEmpty == true) {
      return Center(
        child: Text(
          'There is no news',
          style:
              context.getTextTheme().labelMedium?.copyWith(color: Colors.red),
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
          overlayColor:
              WidgetStatePropertyAll(context.getTextTheme().titleSmall!.color),
          splashBorderRadius: BorderRadius.circular(20),
          labelStyle: context.getTextTheme().titleSmall,
          unselectedLabelStyle: context.getTextTheme().bodySmall,
          tabs: List.generate(
            sources!.length,
            (index) => Tab(
              text: sources?[index].name,
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: List.generate(
              sources!.length,
              (tabIndex) => FutureBuilder(
                future: ArticlesApis.getArticlesBySource(
                    sources?[tabIndex].id ?? 'null'),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: context.getTextTheme().titleSmall!.color,
                      ),
                    );
                  } else if (asyncSnapshot.hasError) {
                    return Center(
                      child: Text(
                        asyncSnapshot.error.toString(),
                        style: context.getTextTheme().labelMedium,
                      ),
                    );
                  }
                  List<Articles> articles = asyncSnapshot.data ?? [];
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        articles == []
                            ? Center(
                                child: Text(
                                  'There is no news',
                                  style: context.getTextTheme().labelMedium,
                                ),
                              )
                            : Expanded(
                                child: ListView.separated(
                                  itemCount: articles.length,
                                  itemBuilder: (context, index) => ArticleCard(
                                    article: articles[index],
                                  ),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    height: 16,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
