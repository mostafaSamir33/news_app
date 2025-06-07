import 'package:flutter/material.dart';
import 'package:news_app/common/app_colors.dart';
import 'package:news_app/common/custom_text_styles.dart';
import 'package:news_app/common/extensions/context_extension.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Image.network(
              'https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE=',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '40-year-old man falls 200 feet to his death while canyoneering at national park',
              style: context.getTextTheme().titleSmall,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.getScreenSize().width * 0.60,
                child: Text(
                  'By : Jon Haworth',
                  style: CustomTextStyles.style14w500White
                      .copyWith(color: AppColors.grey, fontSize: 12),
                ),
              ),
              SizedBox(
                width: context.getScreenSize().width * 0.24,
                child: Text(
                  '15 minutes ago',
                  style: CustomTextStyles.style14w500White
                      .copyWith(color: AppColors.grey, fontSize: 12),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
