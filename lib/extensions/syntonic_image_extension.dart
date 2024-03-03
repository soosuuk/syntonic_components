// import 'dart:ui';

import 'package:flutter/material.dart' as material;
// import 'package:image/image.dart';
import 'package:palette_generator/palette_generator.dart';

extension SyntonicImageExtension on material.Image {
  Future<PaletteGenerator> updatePaletteGenerator() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      image,
    );
    return paletteGenerator;
  }
  // /// 上位4つの色を返す
  // Future<List<material.Color>> colorBy() async {
  //
  //   // 処理を軽くするためにリサイズ（当然結果が変わるので注意）
  //   final resizedImage = this;
  //
  //   // ピクセルごとのargb形式のintのリスト
  //   List<int> pixels = [];
  //
  //   for (int y = 0; y < resizedImage.height; y++) {
  //     for (int x = 0; x < resizedImage.width; x++) {
  //       // 画像のピクセルの色を取得
  //       final pixel = resizedImage.getPixel(x, y);
  //
  //       pixels.add(
  //         ColorUtils.argbFromRgb(
  //           pixel.r.toInt(),
  //           pixel.g.toInt(),
  //           pixel.b.toInt(),
  //         ),
  //       );
  //     }
  //   }
  //
  //   // セレビィさん考案のアルゴリズムで量子化
  //   final quantizerResult = await QuantizerCelebi().quantize(pixels, 128);
  //   // 量子化した色のリストをスコアリング
  //   final ranked = Score.score(quantizerResult.colorToCount);
  //
  //   // スコアの高い4色を返す
  //   return ranked
  //       .take(4)
  //       .map(
  //         (colorInt) => material.Color(colorInt),
  //   )
  //       .toList();
  // }
}
