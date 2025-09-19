import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

class OpenGraphProtocolService {
  static final _instance = OpenGraphProtocolService._internal();

  OpenGraphProtocolService._internal();

  factory OpenGraphProtocolService() {
    return _instance;
  }

  static Future<String?> gett({required String url}) async {
    Response response = await get(Uri.parse(url));
    // computeでパース処理を別スレッド化
    return compute(_parseOpenGraphImage, response.body);
  }

  // 別スレッドで実行するパース処理
  static String? _parseOpenGraphImage(String html) {
    final document = parse(html);
    String? src;

    // ヘッダー内のmetaタグをすべて取得
    var metas = document.head?.getElementsByTagName('meta') ?? [];
    for (var meta in metas) {
      if (meta.attributes['property'] == 'og:image') {
        src = meta.attributes['content'];
      }
    }
    return src;
  }
}
