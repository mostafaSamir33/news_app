import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/models/article_response_model.dart';
import 'package:news_app/network/searched_articles_apis.dart';

class SearchViewModelProvider extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();

  List<Articles> articles = [];
  bool loading = false;
  String? errorMessage;

  Future<void> getSearchedArticles() async {
    articles = [];
    loading = true;
    errorMessage = null;
    notifyListeners();
    try {
      articles =
          await SearchedArticlesApis.getSearchedArticlesByQ(controller.text) ??
              [];
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
    loading=false;
    notifyListeners();
  }

  void clearArticles(){
    articles=[];
    notifyListeners();
  }
}
