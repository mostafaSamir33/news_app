import 'package:news_app/common/failure/failure_model.dart';
import 'package:news_app/features/sources/model/source_response_model.dart';
import 'package:news_app/features/sources/model/sources_data_source.dart';

class SourcesRepository {
  final SourcesDataSource sourcesDataSource;

  SourcesRepository({required this.sourcesDataSource});

  Future<List<SourceModel>> getSources(String categoryId) async {
    try {
      List<SourceModel> response =
          await sourcesDataSource.getSourcesByCategory(categoryId);
      return response;
    } catch (error) {
      throw FailureModel.errorHandling(error);
    }
  }
}
