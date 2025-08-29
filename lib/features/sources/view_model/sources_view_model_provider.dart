// import 'package:flutter/material.dart';
// import 'package:news_app/common/dependency_injection.dart';
// import 'package:news_app/common/failure/failure_model.dart';
// import 'package:news_app/features/sources/model/repository_pattern/sources_repository.dart';
//
// import '../model/source_response_model.dart';
//
// class SourcesViewModelProvider extends ChangeNotifier {
//   SourcesRepository sourcesRepository = SourcesRepository(
//       sourcesDataSource: DependencyInjection.sourcesDataSource);
//   List<SourceModel> sources = [];
//   bool loading = false;
//   String? errorMessage;
//
//   Future<void> getSources(String categoryId) async {
//     sources = [];
//     errorMessage = null;
//     loading = true;
//     notifyListeners();
//     try {
//       sources = await sourcesRepository.getSources(categoryId);
//     } on FailureModel catch (e) {
//       errorMessage = e.errorMessage;
//     } catch (e) {
//       errorMessage = e is String ? e : 'Something went wrong';
//     }
//     loading = false;
//     notifyListeners();
//   }
// }
