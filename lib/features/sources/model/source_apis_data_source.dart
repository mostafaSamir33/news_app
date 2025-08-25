import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/common/app_constants.dart';
import 'package:news_app/common/failure/failure_model.dart';
import 'package:news_app/features/sources/model/source_response_model.dart';
import 'package:news_app/features/sources/model/sources_data_source.dart';

import '../../../common/api_endpoints.dart';

class SourceApisDataSources implements SourcesDataSource {
  @override
  Future<List<SourceModel>> getSourcesByCategory(String category) async {
    Uri uri = Uri.https(AppConstants.baseUrl, ApiEndpoints.sources,
        {'apiKey': AppConstants.apiKey, 'category': category});
    try {
      http.Response response = await http.get(uri);

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      SourceResponseModel data = SourceResponseModel.fromJson(jsonResponse);
      log('sources request uri: ${uri.toString()}');
      log('sources response reasonPhrase: ${response.reasonPhrase}');
      log('sources response2 body: ${response.body}');

      if (data.status == 'ok' && response.statusCode == 200) {
        return data.sources ?? [];
      } else {
        throw FailureModel(
            errorMessage: data.message ?? 'something went wrong');
      }
    } catch (e) {
      throw FailureModel.errorHandling(e);
    }
  }
}
