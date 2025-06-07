import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/widgets/news_card.dart';

class CategoryDetailsView extends StatelessWidget {
  const CategoryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Column(
        children: [
          TabBar(
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
              10,
              (index) => Tab(
                text: 'tab ${index + 1}',
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
                children: List.generate(
              10,
              (tabIndex) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: 10,
                        itemBuilder: (context, index) => const NewsCard(),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}
