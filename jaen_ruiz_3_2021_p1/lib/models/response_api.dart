class response_api {
  bool isSuccess;
  String message;
  dynamic result;

  response_api({required this.isSuccess, this.message = '', this.result});
}