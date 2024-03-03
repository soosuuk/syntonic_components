import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageHelper {
  ImageHelper();

  Image convertBase64ToImageWidget(String base64String) {
    print(
        "ImageHelper convertBase64ToImageWidget before decode base64String====$base64String");
    Image temp = Image.memory(base64Decode(base64String.split(',').last));
    print("ImageHelper convertBase64ToImageWidget after decode");
    // return Image.memory(base64Decode(base64String.split(',').last));
    return temp;
  }

  Image convertBase64ToImageWidgetAndFitHeight(
      String base64String, double height) {
    print(
        "ImageHelper convertBase64ToImageWidgetAndFitHeight before decode base64String====$base64String");
    Image temp = Image.memory(
      base64Decode(base64String.split(',').last),
      height: height,
    );
    print("ImageHelper convertBase64ToImageWidgetAndFitHeight after decode");
    // return Image.memory(base64Decode(base64String.split(',').last), height: height,);
    return temp;
  }

  Future<ui.Image> convertBase64ToUiImage(String base64String) async {
    ui.Image myBackground =
        await decodeImageFromList(base64Decode(base64String.split(',').last));
    return myBackground;
  }

  Future<String> convertUiImageToBase64(ui.Image image) async {
    String result = "";

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData?.buffer.asUint8List();
    result = "data:image/png;base64,${base64Encode(pngBytes!)}";

    return result;
  }

  // String combineWithDataScheme(String base64String) {
  //   return "data:image/png;base64," + base64String.split(',').last;
  // }

  String combineWithDataScheme(String base64String, String? extension) {
    return "data:image/${extension ?? "png"};base64,${base64String.split(',').last}";
  }

  SvgPicture convertBase64ToSVGPictureWithColor(
      String base64String, Color? color) {
    return SvgPicture.memory(
      base64Decode(base64String.split(',').last),
      color: color,
    );
  }
}
