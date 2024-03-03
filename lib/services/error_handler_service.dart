import 'package:async/async.dart';

class ErrorHandlerService<T> {
  static Future<ErrorHandlerService> capture<T>(Function() function) async {
    Result _result = await Result.capture(function());
    if (_result.isError) {
      _result.asError?.handle((error, s) {
        print(error);
        print(s);
      });
    }
    return ErrorHandlerService();
  }
}
