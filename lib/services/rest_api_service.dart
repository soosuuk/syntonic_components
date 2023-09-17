import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:syntonic_components/widgets/snack_bars/syntonic_snack_bar.dart';
import 'package:syntonic_components/widgets/dialogs/syntonic_dialog.dart';
import 'package:syntonic_components/widgets/indicators/syntonic_progress_indicator.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:web_browser_detect/web_browser_detect.dart';
import 'package:syntonic_components/services/localization_service.dart';
import 'package:http_parser/http_parser.dart';

import '../../configs/constants/base_api_paths.dart';
import '../../models/http_response_message_model.dart';
import 'api_exception_service.dart';
import 'local_storage_service.dart';
import 'navigation_service.dart';
import 'dart:developer' as developer;

class RestApiService {
  final String host;
  
  RestApiService({required this.host});

  late bool isSynchronous = false;
  final currentContext = NavigationService().navigatorKey.currentState?.context;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static const headers = <String, String>{'content-type': 'application/json'};

  Future<dynamic> get(
      {required String path,
        Map<String, String>? parameters,
        bool isSynchronous = false,
        Function()? onSucceeded,
        Function()? onFailed}) async {
    Response response;
    this.isSynchronous = isSynchronous;

    try {
      // print(host);
      // print(path);
      // print(Uri.https(host, path));
      final uri = Uri.https(host, path, parameters);
      // _showProgressDialogOnCurrentContext();
      response = await http.get(uri);
      // _dismissProgressDialogOnCurrentContext();

      // developer.log(response.body);

      return _parseResponse(response, onSucceeded, onFailed);
    } on SocketException {
      // _dismissProgressDialogOnCurrentContext();
      throw ConnectionException();
    }
  }

  Future<dynamic> post(
      {required String path,
      Map<String, dynamic>? parameters,
      bool isSynchronous = false,
      Function()? onSucceeded,
      Function()? onFailed}) async {
    Response response;
    this.isSynchronous = isSynchronous;

    try {
      print(host);
      print(path);
      print(Uri.https(host, path));
      final uri = Uri.https(host, path);
      // _showProgressDialogOnCurrentContext();

      developer.log(json.encode(parameters));
      response = await http.post(uri,
          headers: headers,
          body: json.encode(parameters));
      // _dismissProgressDialogOnCurrentContext();

      developer.log(response.body);

      return _parseResponse(response, onSucceeded, onFailed);
    } on SocketException {
      // _dismissProgressDialogOnCurrentContext();
      throw ConnectionException();
    }
  }

  void _showProgressDialogOnCurrentContext() {
    if (!isSynchronous) {
      return;
    }

    if (currentContext != null) {
      SyntonicProgressIndicator(
        iShowProgress: true,
      ).showProgressDialogFullScreen(currentContext!);
    }
  }

  void _dismissProgressDialogOnCurrentContext() {
    if (!isSynchronous) {
      return;
    }

    if (currentContext != null) {
      Navigator.of(currentContext!).pop();
    }
  }

  /// レスポンス結果を元に処理する
  /// 2xx系の場合、正常完了のメッセージをsnack barで表示し、データを返却する
  /// 3xx系の場合、redirectionに関するレスポンスなので一応無視する
  /// 4xx系の場合、responseのメッセージをアラートで表示し、クライアントエラーとして返却する
  /// 5xx系の場合、サーバエラーとして返却する
  /// その他の場合、unknown exceptionとして返却する
  dynamic _parseResponse(
      Response response, Function()? onSucceeded, Function()? onFailed) async {

    final int _statusCode = response.statusCode;
    Map<String, dynamic> _body = {};

    try {
      _body = jsonDecode(response.body);
    } catch (e) {
      if (currentContext != null) {
        ApiExceptionMapper.controlException(
            error: UnknownException(), context: currentContext!);
      }
    }

    HttpResponseMessageModel? _message = _body['message'] == null
        ? null
        : HttpResponseMessageModel.fromJson(_body['message']);
    // Map<String, dynamic>? _data = _body['data'] ?? {};

    if (_statusCode == 119) {
      await SyntonicDialog.show(
        context: currentContext!,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: _message != null ? Text(_message!.title!) : null,
          );
        },
      );
    }

    if (_statusCode >= 200 && _statusCode < 300) {
      if (_message != null) {
        _showMsgSnackBar(_message);
      }
      if (onSucceeded != null) {
        onSucceeded();
      }
      return _body;
    } else if (_statusCode == 403) {
      // 403: A token expired.
      // LocalStorageService.deleteLocalstorage();
    } else if (_statusCode == 409) {
      throw ClientConfirmationRequiredException(responseMessage: _message);
    } else if (_statusCode >= 400 && _statusCode < 500) {
      if (_message != null) {
        _showMsgAlert(_message);
      }
      if (onFailed != null) {
        onFailed();
      }
      return Future.error(
          "Error Info", StackTrace.fromString("StackTrace Error message"));
    } else if (_statusCode >= 500 && _statusCode < 600) {
      if (_message != null) {
        _showMsgAlert(_message);
      }
      if (onFailed != null) {
        onFailed();
      }
      return Future.error(
          "Error Info", StackTrace.fromString("StackTrace Error message"));
    } else {
      if (currentContext != null) {
        // return Future.error("Error Info", StackTrace.fromString("StackTrace Error message"));

      }
    }
  }

  /// メッセージをsnack barで表示する
  void _showMsgSnackBar(HttpResponseMessageModel? message) {
    if (currentContext != null) {
      SyntonicSnackBar().showSnackBar(
          context: currentContext!, message: message?.content ?? "");
    }
  }

  /// メッセージをアラートで表示する
  void _showMsgAlert(HttpResponseMessageModel? message) {
    List<SyntonicDialogButtonInfoModel> _buttonList = [];

    _buttonList.add(SyntonicDialogButtonInfoModel(
        buttonTxt: LocalizationService().localize.ok,
        buttonAction: () => null));

    if (currentContext != null) {
      showDialog(
          context: currentContext!,
          builder: (currentContext) => SyntonicDialog(
                title: message?.title,
                content: message?.content,
                buttonInfoList: _buttonList,
              ));
    }
  }
}
