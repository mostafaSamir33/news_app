import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/features/articles/model/article_response_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/app_colors.dart';

class ArticleBottomSheet extends StatelessWidget {
  final Articles article;

  const ArticleBottomSheet({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: context.getTextTheme().labelMedium!.color,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: context.getScreenSize().height * 0.25,
                  width: double.infinity,
                  color: AppColors.grey.withValues(alpha: 0.1),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ?? '',
                    placeholder: (context, url) => Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: context.getTextTheme().titleSmall!.color,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported_rounded,
                      color: AppColors.grey,
                      size: 200,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  article.description ?? '',
                  style: context.getTextTheme().bodySmall!.copyWith(
                      color: context.getThemeData().scaffoldBackgroundColor),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse(article.url ?? ''),
                      mode: LaunchMode.inAppWebView);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        context.getThemeData().scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    minimumSize: Size(double.infinity,
                        context.getScreenSize().height * 0.065)),
                child: Text(
                  context.getLocalization().viewFullArticle,
                  style: context.getTextTheme().titleSmall,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
