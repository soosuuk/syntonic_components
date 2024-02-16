import 'package:flutter/material.dart' as material;
import 'package:image/image.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:material_color_utilities/utils/color_utils.dart';

extension SyntonicImageExtension on Image {
  /// 上位4つの色を返す
  Future<List<material.Color>> get color async {
    // 処理を軽くするためにリサイズ（当然結果が変わるので注意）
    final resizedImage = copyResize(this, width: 512, height: 512);

    // ピクセルごとのargb形式のintのリスト
    List<int> pixels = [];

    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        // 画像のピクセルの色を取得
        final pixel = resizedImage.getPixel(x, y);

        pixels.add(
          ColorUtils.argbFromRgb(
            pixel.r.toInt(),
            pixel.g.toInt(),
            pixel.b.toInt(),
          ),
        );
      }
    }

    // セレビィさん考案のアルゴリズムで量子化
    final quantizerResult = await QuantizerCelebi().quantize(pixels, 128);
    // 量子化した色のリストをスコアリング
    final ranked = Score.score(quantizerResult.colorToCount);

    // スコアの高い4色を返す
    return ranked
        .take(4)
        .map(
          (colorInt) => material.Color(colorInt),
    )
        .toList();
  }
}