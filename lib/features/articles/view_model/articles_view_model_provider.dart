// import 'package:flutter/material.dart';
// import 'package:news_app/common/dependency_injection.dart';
// import 'package:news_app/common/failure/failure_model.dart';
// import 'package:news_app/features/articles/model/repository/articles_repository.dart';
//
// import '../model/article_response_model.dart';
//
// class ArticlesViewModelProvider extends ChangeNotifier {
//   ArticlesRepository articlesRepository = ArticlesRepository(
//       articlesDataSource: DependencyInjection.articlesDataSource);
//   List<Articles> articles = [];
//   bool loading = false;
//   String? errorMessage;
//
//   Future<void> getArticles(String sourceId) async {
//     articles = [];
//     errorMessage = null;
//     loading = true;
//     notifyListeners();
//     try {
//       articles = await articlesRepository.getArticlesBySource(sourceId);
//     } on FailureModel catch (e) {
//       errorMessage = e.errorMessage;
//     } catch (e) {
//       errorMessage = e is String ? e : 'Something went wrong';
//     }
//     loading = false;
//     notifyListeners();
//   }
// }
