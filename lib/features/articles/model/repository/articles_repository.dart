import 'package:news_app/features/articles/model/articles_data_source.dart';

import '../../../../common/failure/failure_model.dart';
import '../article_response_model.dart';

class ArticlesRepository {
  final ArticlesDataSource articlesDataSource;

  ArticlesRepository({required this.articlesDataSource});

  Future<List<Articles>> getArticlesBySource(String sourceId) async {
    try {
      List<Articles> response =
          await articlesDataSource.getArticlesBySource(sourceId);
      return response;
    } catch (error) {
      throw FailureModel.errorHandling(error);
    }
  }
}
