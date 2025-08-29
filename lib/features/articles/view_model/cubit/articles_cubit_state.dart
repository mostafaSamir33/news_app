import '../../model/article_response_model.dart';

sealed class ArticlesCubitState {}

class ArticlesCubitInitialState extends ArticlesCubitState {}

class GetArticlesLoading extends ArticlesCubitState {}

class GetArticlesEmptyList extends ArticlesCubitState {}

class GetArticlesSuccess extends ArticlesCubitState {
  final List<Articles> articles;

  GetArticlesSuccess({required this.articles});
}

class GetArticlesFailure extends ArticlesCubitState {
  final String errorMessage;

  GetArticlesFailure({required this.errorMessage});
}
