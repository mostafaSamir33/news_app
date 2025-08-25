import 'package:news_app/features/sources/model/source_response_model.dart';
import 'package:news_app/features/sources/model/sources_data_source.dart';

class SourcesFirebaseDataSource implements SourcesDataSource {
  @override
  Future<List<SourceModel>> getSourcesByCategory(String category) async {
    return [];
  }
}
