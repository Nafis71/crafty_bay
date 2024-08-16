class Failure {
  Object? response;
  int? statusCode;
  String? errorMessage;

  Failure({required this.statusCode, this.response, this.errorMessage});
}
