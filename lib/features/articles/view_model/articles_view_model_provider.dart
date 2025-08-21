import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/features/articles/model/articles_apis.dart';

import '../model/article_response_model.dart';

class ArticlesViewModelProvider extends ChangeNotifier {
  ArticlesApis articlesApis = ArticlesApis();
  List<Articles> articles = [];
  bool loading = false;
  String? errorMessage;

  Future<void> getArticles(String sourceId) async {
    articles = [];
    errorMessage = null;
    loading = true;
    notifyListeners();
    try {
      articles = await articlesApis.getArticlesBySource(sourceId) ?? [];
    } on ClientException catch (error) {
      errorMessage =
          'Something wrong with the server, try again later\n${error.message}';
    } catch (e) {
      errorMessage = e is String ? e : 'Something went wrong';
    }
    loading = false;
    notifyListeners();
  }
}
