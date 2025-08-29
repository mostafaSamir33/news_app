import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/sources/view_model/cubit/sources_cubit_state.dart';

import '../../../../common/dependency_injection.dart';
import '../../../../common/failure/failure_model.dart';
import '../../model/repository_pattern/sources_repository.dart';
import '../../model/source_response_model.dart';

class SourcesCubit extends Cubit<SourcesCubitState> {
  SourcesCubit() : super(SourcesCubitInitialState());
  SourcesRepository sourcesRepository =
      SourcesRepository(sourcesDataSource: getIt.get());

  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoading());
    try {
      List<SourceModel> sources =
          await sourcesRepository.getSources(categoryId);
      emit(sources.isEmpty
          ? GetSourcesEmptyList()
          : GetSourcesSuccess(sources: sources));
    } on FailureModel catch (e) {
      emit(GetSourcesFailure(errorMessage: e.errorMessage));
    } catch (e) {
      emit(GetSourcesFailure(errorMessage: e.toString()));
    }
  }
}
