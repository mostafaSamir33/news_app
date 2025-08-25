import 'package:news_app/features/articles/model/articles_apis_data_source.dart';
import 'package:news_app/features/articles/model/articles_data_source.dart';
import 'package:news_app/features/search_for_article/model/searched_articles_apis_data_source.dart';
import 'package:news_app/features/search_for_article/model/searched_articles_data_source.dart';
import 'package:news_app/features/sources/model/source_apis_data_source.dart';
import 'package:news_app/features/sources/model/sources_data_source.dart';

class DependencyInjection {
  static SourcesDataSource sourcesDataSource = SourceApisDataSources();
  static ArticlesDataSource articlesDataSource = ArticlesApisDataSource();
  static SearchedArticlesDataSource searchedArticlesDataSource =
      SearchedArticlesApisDataSource();
}
