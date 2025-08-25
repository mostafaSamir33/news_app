import 'article_response_model.dart';

abstract class ArticlesDataSource {
  Future<List<Articles>> getArticlesBySource(String sourceId);
}
