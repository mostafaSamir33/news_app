import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/providers/search_view_model_provider.dart';
import 'package:news_app/widgets/article_card.dart';
import 'package:news_app/widgets/custom_search_bar.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/searchScreen';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: CustomSearchBar(),
            floating: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
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
                      context.read<SearchViewModelProvider>().articles.length,
                  itemBuilder: (context, index) => ArticleCard(
                      article: context
                          .read<SearchViewModelProvider>()
                          .articles[index]),
                  separatorBuilder: (context, index) => SizedBox(
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
