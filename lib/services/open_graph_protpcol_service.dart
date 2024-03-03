import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:html/parser.dart' show parse;

import 'package:http/http.dart';


class OpenGraphProtocolService {
  static final _instance = OpenGraphProtocolService._internal();

  OpenGraphProtocolService._internal();

  factory OpenGraphProtocolService() {
    return _instance;
  }

  static Future<String?> gett({required String url}) async {
    // const String url = 'https://flutterlabo.tech/';
    Widget title;
    Widget? image;
    Widget? description;
    late String? src;

// URLにアクセスして情報をすべて取得
    Response response = await get(Uri.parse(url));

// HTMLパッケージでHTMLタグとして認識
    var document = parse(response.body);

// ヘッダー内のtitleタグの中身を取得
    title = Text(
      document.head!.getElementsByTagName('title')[0].innerHtml,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(fontSize: 13),
    );

// ヘッダー内のmetaタグをすべて取得
    var metas = document.head!.getElementsByTagName('meta');
    for (var meta in metas) {
      // metaタグの中からname属性がdescriptionであるものを探す
      if (meta.attributes['name'] == 'description') {
        description = Text(
          meta.attributes['content'] ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: const TextStyle(fontSize: 12),
        );

        // metaタグの中からproperty属性がog:imageであるものを探す
      } else if (meta.attributes['property'] == 'og:image') {
        src = meta.attributes['content'];
        // image = ClipRRect(
        //   borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        //   child: Image.network(
        //     meta.attributes['content']!,
        //     width: 120,
        //     height: 120,
        //     fit: BoxFit.cover,
        //     alignment: Alignment.center,
        //   ),
        // );
      }
    }

    return src;
    // return ([image, title, description].every((element) => element != null)) ? InkWell(
    //   onTap: () async  {
    //     if(await canLaunch(url)) launch(url);
    //   },
    //   child: Container(
    //     height: 120,
    //     decoration: BoxDecoration(
    //         border: Border.all(width: 0.5, color: Colors.grey),
    //         borderRadius: const BorderRadius.all(Radius.circular(10))
    //     ),
    //     child: Row(
    //       children: [
    //         image!,
    //         Expanded(
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 8),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 title, description!
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // ) : const SizedBox();
  }
}
