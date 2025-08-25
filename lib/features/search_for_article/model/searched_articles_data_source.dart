import '../../articles/model/article_response_model.dart';

abstract class SearchedArticlesDataSource {
  Future<List<Articles>> getSearchedArticlesByQ(
      {required String searchQuery, required int page, int pageSize = 10});
}
