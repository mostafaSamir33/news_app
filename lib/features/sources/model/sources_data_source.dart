import 'package:news_app/features/sources/model/source_response_model.dart';

abstract class SourcesDataSource {
  Future<List<SourceModel>> getSourcesByCategory(String category);
}
