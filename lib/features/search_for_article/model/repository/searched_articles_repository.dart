import 'package:news_app/features/search_for_article/model/searched_articles_data_source.dart';

import '../../../../common/failure/failure_model.dart';
import '../../../articles/model/article_response_model.dart';

class SearchedArticlesRepository {
  final SearchedArticlesDataSource searchedArticlesDataSource;

  SearchedArticlesRepository({required this.searchedArticlesDataSource});

  Future<List<Articles>> getSearchedArticlesByQ(
      {required String searchQuery,
      required int page,
      int pageSize = 10}) async {
    try {
      List<Articles> response = await searchedArticlesDataSource
          .getSearchedArticlesByQ(searchQuery: searchQuery, page: page);
      return response;
    } catch (error) {
     throw FailureModel.errorHandling(error);
    }
  }
}
