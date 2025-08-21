import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/features/search_for_article/view_model/search_view_model_provider.dart';
import 'package:news_app/features/search_for_article/view/custom_search_bar.dart';
import 'package:provider/provider.dart';

import '../../../articles/view/article_card.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/searchScreen';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: context.read<SearchViewModelProvider>().scrollController,
        slivers: [
          const SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: CustomSearchBar(),
            floating: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: Consumer<SearchViewModelProvider>(
              builder: (context, provider, child) {
                if (provider.loading) {
                  return SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: context.getTextTheme().labelSmall!.color,
                      ),
                    ),
                  );
                }
                if (provider.errorMessage != null) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        provider.errorMessage ?? '',
                        style: context.getTextTheme().labelSmall,
                      ),
                    ),
                  );
                }
                if (provider.articles.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No articles found',
                        style: context.getTextTheme().labelSmall,
                      ),
                    ),
                  );
                }

                return SliverList.separated(
                  itemCount:
                      context.read<SearchViewModelProvider>().articles.length +
                          (provider.paginationLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (provider.paginationLoading &&
                        index == provider.articles.length) {
                      return Center(
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: CircularProgressIndicator(
                              color: context.getTextTheme().labelSmall!.color,
                            )),
                      );
                    }
                    return ArticleCard(
                        article: context
                            .read<SearchViewModelProvider>()
                            .articles[index]);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
