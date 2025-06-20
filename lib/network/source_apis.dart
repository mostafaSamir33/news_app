import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/common/app_constants.dart';
import 'package:news_app/models/source_response_model.dart';

import '../common/api_endpoints.dart';

class SourceApis {
  static Future<List<SourceModel>?> getSourcesByCategory(
      String category) async {
    Uri uri = Uri.https(AppConstants.baseUrl, ApiEndpoints.sources,
        {'apiKey': AppConstants.apiKey, 'category': category});

    http.Response response = await http.get(uri);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    SourceResponseModel data = SourceResponseModel.fromJson(jsonResponse);
    log('sources request uri: ${uri.toString()}');
    log('sources response reasonPhrase: ${response.reasonPhrase}');
    log('sources response2 body: ${response.body}');
    // log('sources response3 bodyBytes: ${response.bodyBytes}');
    // log('sources response3 headers: ${response.headers}');
    // log('sources response3 statusCode: ${response.statusCode}');

    if (data.status == 'ok' && response.statusCode == 200) {
      return data.sources;
    } else {
      throw data.message ?? 'something went wrong';
    }
  }
}
