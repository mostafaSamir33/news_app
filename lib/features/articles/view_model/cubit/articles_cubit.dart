import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/articles/view_model/cubit/articles_cubit_state.dart';

import '../../../../common/dependency_injection.dart';
import '../../../../common/failure/failure_model.dart';
import '../../model/article_response_model.dart';
import '../../model/repository/articles_repository.dart';

class ArticlesCubit extends Cubit<ArticlesCubitState> {
  ArticlesCubit() : super(ArticlesCubitInitialState());
  ArticlesRepository articlesRepository =
      ArticlesRepository(articlesDataSource: getIt.get());

  Future<void> getArticles(String sourceId) async {
    emit(GetArticlesLoading());
    try {
      List<Articles> articles =
          await articlesRepository.getArticlesBySource(sourceId);
      emit(articles.isEmpty
          ? GetArticlesEmptyList()
          : GetArticlesSuccess(articles: articles));
    } on FailureModel catch (e) {
      emit(GetArticlesFailure(errorMessage: e.errorMessage));
    } catch (e) {
      emit(GetArticlesFailure(errorMessage: e.toString()));
    }
  }
}
