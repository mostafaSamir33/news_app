import 'article_response_model.dart';
import 'articles_data_source.dart';

class ArticlesFirebaseDataSource implements ArticlesDataSource {
  @override
  Future<List<Articles>> getArticlesBySource(String sourceId) async {
    return [];
  }
}
