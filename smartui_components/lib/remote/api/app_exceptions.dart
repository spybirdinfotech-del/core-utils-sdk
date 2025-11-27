import '../util/string_file.dart';

class AppExceptions implements Exception {
  final _message;

  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}


class InternetException extends AppExceptions {
   InternetException([String? message = '']) : super(message, StringFile.noInternetError);
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message = '']) : super(message, StringFile.requestTimeOut);
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, StringFile.internalServerError);
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message]) : super(message, StringFile.invalidUrl);
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, '');
}