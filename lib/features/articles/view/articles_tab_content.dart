import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/features/articles/view_model/cubit/articles_cubit.dart';
import 'package:news_app/features/articles/view_model/cubit/articles_cubit_state.dart';

import '../../../common/app_colors.dart';
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
        context.read<ArticlesCubit>().getArticles(widget.sourceId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesCubit, ArticlesCubitState>(
      builder: (context, state) {
        switch (state) {
          case ArticlesCubitInitialState() || GetArticlesLoading():
            return Center(
              child: CircularProgressIndicator(
                color: context.getTextTheme().labelMedium!.color,
              ),
            );
          case GetArticlesEmptyList():
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'There is no news',
                      style: context.getTextTheme().labelMedium,
                    ),
                  ),
                ],
              ),
            );
          case GetArticlesSuccess():
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.mainColorLight,
                      backgroundColor: Colors.black,
                      onRefresh: () async {
                        context
                            .read<ArticlesCubit>()
                            .getArticles(widget.sourceId);
                      },
                      child: ListView.separated(
                        itemCount: state.articles.length,
                        itemBuilder: (context, index) => ArticleCard(
                          article: state.articles[index],
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          case GetArticlesFailure():
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
                    state.errorMessage,
                    style: context.getTextTheme().labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<ArticlesCubit>()
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

        // if (state is GetArticlesLoading || state is ArticlesCubitInitialState) {
        //   return Center(
        //     child: CircularProgressIndicator(
        //       color: context.getTextTheme().labelMedium!.color,
        //     ),
        //   );
        // } else if (state is GetArticlesFailure) {
        //   return Center(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       spacing: 8,
        //       children: [
        //         Icon(
        //           Icons.error_outline,
        //           color: context.getTextTheme().labelMedium!.color,
        //         ),
        //         Text(
        //           state.errorMessage,
        //           style: context.getTextTheme().labelMedium,
        //           textAlign: TextAlign.center,
        //         ),
        //         ElevatedButton(
        //           onPressed: () {
        //             context.read<ArticlesCubit>().getArticles(widget.sourceId);
        //           },
        //           child: Text(
        //             'Try Again',
        //             style: context.getTextTheme().labelMedium,
        //           ),
        //         )
        //       ],
        //     ),
        //   );
        // } else {
        //   return Padding(
        //     padding: const EdgeInsets.all(16),
        //     child: Column(
        //       children: [
        //         state is GetArticlesEmptyList
        //             ? Center(
        //                 child: Text(
        //                   'There is no news',
        //                   style: context.getTextTheme().labelMedium,
        //                 ),
        //               )
        //             : state is GetArticlesSuccess
        //                 ? Expanded(
        //                     child: RefreshIndicator(
        //                       color: AppColors.mainColorLight,
        //                       backgroundColor: Colors.black,
        //                       onRefresh: () async {
        //                         context
        //                             .read<ArticlesCubit>()
        //                             .getArticles(widget.sourceId);
        //                       },
        //                       child: ListView.separated(
        //                         itemCount: state.articles.length,
        //                         itemBuilder: (context, index) => ArticleCard(
        //                           article: state.articles[index],
        //                         ),
        //                         separatorBuilder:
        //                             (BuildContext context, int index) =>
        //                                 const SizedBox(
        //                           height: 16,
        //                         ),
        //                       ),
        //                     ),
        //                   )
        //                 : const SizedBox.shrink()
        //       ],
        //     ),
        //   );
        // }
      },
    );
  }
}
