import 'package:http/http.dart';

class FailureModel implements Exception {
  final String errorMessage;

  FailureModel({required this.errorMessage});

  static FailureModel errorHandling(error) {
    if (error is Exception) {
      if (error is TypeError) {
        return FailureModel(errorMessage: 'Error parsing an object');
      } else if (error is ClientException) {
        return NetworkFailure(errorMessage: 'Error with the network');
      } else {
        return FailureModel(errorMessage: 'Something went wrong');
      }
    } else {
      return FailureModel(errorMessage: 'Error: ${error.toString()}');
    }
  }
}

class NetworkFailure extends FailureModel {
  NetworkFailure({required super.errorMessage});
}
