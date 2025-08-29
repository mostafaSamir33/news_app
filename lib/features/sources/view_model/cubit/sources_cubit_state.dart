import '../../model/source_response_model.dart';

sealed class SourcesCubitState {}

class SourcesCubitInitialState extends SourcesCubitState {}

class GetSourcesSuccess extends SourcesCubitState {
  final List<SourceModel> sources;

  GetSourcesSuccess({required this.sources});
}

class GetSourcesLoading extends SourcesCubitState {}
class GetSourcesEmptyList extends SourcesCubitState {}

class GetSourcesFailure extends SourcesCubitState {
  final String errorMessage;

  GetSourcesFailure({required this.errorMessage});
}
