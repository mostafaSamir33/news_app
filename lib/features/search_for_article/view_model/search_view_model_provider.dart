import 'package:flutter/material.dart';
import 'package:news_app/common/dependency_injection.dart';
import 'package:news_app/features/articles/model/article_response_model.dart';
import 'package:news_app/features/search_for_article/model/repository/searched_articles_repository.dart';

import '../../../common/failure/failure_model.dart';

class SearchViewModelProvider extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  SearchedArticlesRepository searchedArticlesRepository =
      SearchedArticlesRepository(searchedArticlesDataSource: getIt.get());

  List<Articles> articles = [];
  bool loading = false;
  String? errorMessage;

  bool paginationLoading = false;

  int page = 1;

  SearchViewModelProvider() {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge) {
          bool isTop = scrollController.position.pixels == 0;
          if (!isTop && !paginationLoading) {
            page++;
            paginationLoading = true;
            notifyListeners();
            getSearchedArticles();
          }
        }
      },
    );
  }

  Future<void> getSearchedArticles() async {
    List<Articles> newArticles = [];
    errorMessage = null;
    if (articles.isEmpty) {
      loading = true;
      notifyListeners();
    }
    try {
      newArticles = await searchedArticlesRepository.getSearchedArticlesByQ(
          searchQuery: controller.text, page: page);
      articles.addAll(newArticles);
    } on FailureModel catch (error) {
      errorMessage = error.errorMessage;
    } catch (e) {
      errorMessage = e is String ? e : 'something went wrong';
    }
    loading = false;
    paginationLoading = false;
    notifyListeners();
  }

  void clearArticles() {
    articles = [];
    notifyListeners();
  }
}
