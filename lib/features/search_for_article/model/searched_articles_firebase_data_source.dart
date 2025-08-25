import 'package:news_app/features/search_for_article/model/searched_articles_data_source.dart';

import '../../articles/model/article_response_model.dart';

class SearchedArticlesFirebaseDataSource implements SearchedArticlesDataSource {
  @override
  Future<List<Articles>> getSearchedArticlesByQ(
      {required String searchQuery,
      required int page,
      int pageSize = 10}) async {
    return [];
  }
}
