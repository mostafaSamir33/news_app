import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:provider/provider.dart';

import '../../../common/app_colors.dart';
import '../view_model/articles_view_model_provider.dart';
import 'article_card.dart';

class TabContent extends StatefulWidget {
  const TabContent({
    super.key,
    required this.sourceId,
  });

  final String sourceId;

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<ArticlesViewModelProvider>().getArticles(widget.sourceId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticlesViewModelProvider>(
      builder: (context, provider, child) {
        if (provider.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: context.getTextTheme().labelMedium!.color,
            ),
          );
        }
        if (provider.errorMessage != null) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(
                  Icons.error_outline,
                  color: context.getTextTheme().labelMedium!.color,
                ),
                Text(
                  provider.errorMessage!,
                  style: context.getTextTheme().labelMedium,
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<ArticlesViewModelProvider>()
                        .getArticles(widget.sourceId);
                  },
                  child: Text(
                    'Try Again',
                    style: context.getTextTheme().labelMedium,
                  ),
                )
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              provider.articles == []
                  ? Center(
                      child: Text(
                        'There is no news',
                        style: context.getTextTheme().labelMedium,
                      ),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        color: AppColors.mainColorLight,
                        backgroundColor: Colors.black,
                        onRefresh: () async {
                          context
                              .read<ArticlesViewModelProvider>()
                              .getArticles(widget.sourceId);
                        },
                        child: ListView.separated(
                          itemCount: provider.articles.length,
                          itemBuilder: (context, index) => ArticleCard(
                            article: provider.articles[index],
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 16,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
