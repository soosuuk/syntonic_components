import 'package:syntonic_components/models/http_response_message_model.dart';
import 'package:syntonic_components/services/localization_service.dart';
import 'package:syntonic_components/widgets/dialogs/syntonic_dialog.dart';
import 'package:flutter/material.dart';

abstract class ApiExceptionService implements Exception {
  String? title;
  String? content;

  ApiExceptionService();
}

class ConnectionException extends ApiExceptionService {}

class ServerErrorException extends ApiExceptionService {}

class ClientErrorException extends ApiExceptionService {}

class UnknownException extends ApiExceptionService {}

class ClientConfirmationRequiredException extends ApiExceptionService {
  ClientConfirmationRequiredException(
      {required HttpResponseMessageModel? responseMessage}) {
    title = responseMessage?.title;
    content = responseMessage?.content;
  }
}

/// 受信したエラー内容に沿って処理する
abstract class ApiExceptionMapper {
  static void controlException({Object? error, required BuildContext context}) {
    /// TODO: 共通エラーテキストを作成する必要
    if (error is ApiExceptionService) {
      if (error is ConnectionException) {
        /// TODO: 通信エラーのモーダルを表示する必要
        _showErrorAlert(
            errorMessage: "Connection Error Exception occurred!!",
            context: context);
        throw Future.error(
            "Error Info", StackTrace.fromString("StackTrace Error message"));
      } else if (error is ClientErrorException) {
        _showErrorAlert(
            errorMessage: "Client Error Exception occurred!!",
            context: context);
        throw Future.error(
            "Error Info", StackTrace.fromString("StackTrace Error message"));
      } else if (error is ServerErrorException) {
        _showErrorAlert(
            errorMessage: "Sever Error Exception occurred!!", context: context);
        throw Future.error(
            "Error Info", StackTrace.fromString("StackTrace Error message"));
      } else {
        _showErrorAlert(
            errorMessage: "Unknown Error occurred!!", context: context);
        throw Future.error(
            "Error Info", StackTrace.fromString("StackTrace Error message"));
      }
    } else {
      _showErrorAlert(
          errorMessage: "Unknown Error occurred!!", context: context);
      throw Future.error(
          "Error Info", StackTrace.fromString("StackTrace Error message"));
    }
  }

  /// 共通のエラーメッセージをアラートで表示する
  static void _showErrorAlert(
      {required String errorMessage, required BuildContext context}) {
    List<SyntonicDialogButtonInfoModel> _buttonList = [];
    _buttonList.add(SyntonicDialogButtonInfoModel(
        buttonTxt: LocalizationService().localize.ok,
        buttonAction: () {
          print("OK 押下！！}");
        }));
    showDialog(
        context: context,
        builder: (context) => SyntonicDialog(
              content: errorMessage,
              buttonInfoList: _buttonList,
            ));
  }
}
