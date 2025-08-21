import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/features/search_for_article/view_model/search_view_model_provider.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: context.read<SearchViewModelProvider>().controller,
      onChanged: (value) => setState(() {}),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        context.read<SearchViewModelProvider>().getSearchedArticles();
      },
      style: context.getTextTheme().labelSmall,
      cursorColor: context.getTextTheme().labelSmall!.color,
      enableSuggestions: true,
      decoration: InputDecoration(
        hintText: context.getLocalization().search,
        hintStyle: context.getTextTheme().labelSmall,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(color: context.getTextTheme().labelSmall!.color!)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(color: context.getTextTheme().labelSmall!.color!)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(color: context.getTextTheme().labelSmall!.color!)),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: context.getTextTheme().labelSmall!.color,
        ),
        suffixIcon: Visibility(
          visible: context.watch<SearchViewModelProvider>().controller.text.isNotEmpty,
          child: IconButton(
              onPressed: () {
                context.read<SearchViewModelProvider>().controller.clear();
                context.read<SearchViewModelProvider>().clearArticles();
                setState(() {});
              },
              icon: Icon(
                Icons.close_rounded,
                color: context.getTextTheme().labelSmall!.color,
              )),
        ),
      ),
    );
  }
}
