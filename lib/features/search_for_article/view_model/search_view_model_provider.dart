import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/features/articles/model/article_response_model.dart';
import 'package:news_app/features/search_for_article/model/searched_articles_apis.dart';

class SearchViewModelProvider extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

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
      newArticles = await SearchedArticlesApis.getSearchedArticlesByQ(
              searchQuery: controller.text, page: page) ??
          [];
      articles.addAll(newArticles);
    } on ClientException catch (error) {
      errorMessage =
          'something wrong with the server, try again later\n${error.message}';
    } catch (e) {
      if (e is TypeError) {
        errorMessage = 'error formating the received data';
      } else {
        errorMessage = e is String ? e : 'something went wrong';
      }
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
