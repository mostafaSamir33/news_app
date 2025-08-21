import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/features/sources/model/source_apis.dart';

import '../model/source_response_model.dart';

class SourcesViewModelProvider extends ChangeNotifier {
  final SourceApis _sourceApis = SourceApis();
  List<SourceModel> sources = [];
  bool loading = false;
  String? errorMessage;

  Future<void> getSources(String categoryId) async {
    sources = [];
    errorMessage = null;
    loading = true;
    notifyListeners();
    try {
      sources = await _sourceApis.getSourcesByCategory(categoryId) ?? [];
    } on ClientException catch (error) {
      errorMessage =
          'Something wrong with the server, try again later\n${error.message}';
    } catch (e) {
      errorMessage = e is String ? e : 'Something went wrong';
    }
    loading = false;
    notifyListeners();
  }
}
