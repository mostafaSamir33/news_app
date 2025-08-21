import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/app_colors.dart';
import 'package:news_app/common/custom_text_styles.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/features/articles/model/article_response_model.dart';
import 'package:news_app/features/articles/view/article_bottom_sheet.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleCard extends StatelessWidget {
  final Articles article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showArticleBottomSheet(context, article);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(
              color: context.getTextTheme().labelMedium!.color!,
            ),
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
                article.title ?? '',
                style: context.getTextTheme().titleSmall,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    article.author != null ? 'By : ${article.author}' : '',
                    style: CustomTextStyles.style14w500White
                        .copyWith(color: AppColors.grey, fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      timeago.format(DateTime.parse(article.publishedAt ?? '')),
                      style: CustomTextStyles.style14w500White
                          .copyWith(color: AppColors.grey, fontSize: 12),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showArticleBottomSheet(BuildContext context, Articles article) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ArticleBottomSheet(article: article,);
      },
    );
  }
}

