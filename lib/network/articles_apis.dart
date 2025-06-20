import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article_response_model.dart';

import '../common/api_endpoints.dart';
import '../common/app_constants.dart';

class ArticlesApis {
  static Future<List<Articles>?> getArticlesBySource(String sourceId) async {
    Uri uri = Uri.https(AppConstants.baseUrl, ApiEndpoints.everything,
        {'apiKey': AppConstants.apiKey, 'sources': sourceId});

    http.Response response = await http.get(uri);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    ArticleResponseModel data = ArticleResponseModel.fromJson(jsonResponse);
    log('article request: ${uri.toString()}');
    log('article response: ${response.reasonPhrase}');
    log('article response2: ${response.body}');
    if (data.status == 'ok' && response.statusCode == 200) {
      return data.articles;
    } else {
      throw data.message ?? 'something went wrong';
    }
  }
}
