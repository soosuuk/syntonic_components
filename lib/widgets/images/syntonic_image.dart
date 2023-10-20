import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/services/localization_service.dart';
import 'package:syntonic_components/widgets/icons/syntonic_person_icon.dart';
import 'package:syntonic_components/widgets/buttons/syntonic_pop_up_menu_button.dart';
import 'package:syntonic_components/widgets/texts/body_1_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import '../syntonic_base_view.dart';

class SyntonicImage extends StatelessWidget {
  @required
  final Image? image;
  @required
  final Function? onClear;
  @required
  final Function(
      {required Image image,
      required String imageBase64,
      String? extension})? onUpload;

  final bool isEditable;
  final bool needsTrimAsCircle;
  final bool isMini;

  final double? width;
  final double? height;

  const SyntonicImage._({
    required this.image,
    this.onClear,
    this.onUpload,
    this.isMini = false,
    this.isEditable = false,
    this.needsTrimAsCircle = false,
    this.width,
    this.height,
  });

  const SyntonicImage.displayOnly({
    required Image? image,
    double? width,
    double? height,
  }) : this._(image: image, isEditable: false, width: width, height: height);

  const SyntonicImage.displayOnlyMini({
    required Image? image,
  }) : this._(image: image, isEditable: false, isMini: true);

  const SyntonicImage.editable({
    required Image? image,
    required Function? onClear,
    required Function(
            {required Image image,
            required String imageBase64,
            String? extension})?
        onUpload,
    bool needsTrimAsCircle = false,
  }) : this._(
            image: image,
            onClear: onClear,
            onUpload: onUpload,
            isEditable: true,
            needsTrimAsCircle: needsTrimAsCircle);

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkTheme = brightness == Brightness.dark;

    return SizedBox(
      width: width ?? ((this.isMini)
          ? IconSize.large.size
          : null),
      height: height ?? ((this.isMini) ? IconSize.large.size : null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: SizedBox(
              width: width,
              height: height,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: image),
            ),
            // child: Stack(alignment: AlignmentDirectional.topEnd, children: [
            //   Container(
            //       width:
            //       (this.isMini) ? IconSize.large.size : double.infinity,
            //       height: (this.isMini)
            //           ? IconSize.large.size
            //           : MediaQuery.of(context).size.width -
            //           MediaQuery.of(context).size.width / 3,
            //       child: image != null
            //           ? image
            //           : Container(
            //         color: isDarkTheme
            //             ? Colors.white10
            //             : SyntonicColor.black4,
            //         child: Center(
            //           child: Icon(Icons.image,
            //               size: (this.isMini) ? 32 : 112,
            //               color: isDarkTheme
            //                   ? Colors.white70
            //                   : SyntonicColor.black56),
            //         ),
            //       )),
            //   needsTrimAsCircle && image != null
            //       ? CustomPaint(
            //     painter: _HolePainter(
            //         height: MediaQuery.of(context).size.width -
            //             MediaQuery.of(context).size.width / 3),
            //     child: Container(),
            //   )
            //       : image != null
            //       ? Container(
            //     width: width ?? ((this.isMini)
            //         ? IconSize.large.size
            //         : double.infinity),
            //     height: height ?? ((this.isMini) ? IconSize.large.size : 112),
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [Colors.black12, Colors.transparent],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //       ),
            //     ),
            //   )
            //       : SizedBox(),
            //   isEditable
            //       ? SyntonicPopupMenuButton(
            //       icon: Icons.more_vert,
            //       popUpMenuItem: [
            //         PopUpMenuItem(
            //             title: LocalizationService().localize.upload,
            //             onTap: () =>
            //             // _imageOverSizeAlert(context: context)),
            //             _browseImageExplorer(context: context)),
            //         PopUpMenuItem(
            //           title: LocalizationService().localize.clear,
            //           onTap: () => onClear!(),
            //         )
            //       ])
            //       : SizedBox(),
            // ]),
          )
        ],
      ),
    );
  }

  Future<void> _imageOverSizeAlert({required BuildContext context}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              content: Body1Text(
                  text:
                  "5MB以下の画像を選択してください。"),
              actions: <Widget>[
                TextButton(
                  child: Body1Text(text: LocalizationService().localize.ok),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ));
      },
    );
  }

  Future<void> _browseImageExplorer({required BuildContext context}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'webp'],
      );

      if (result != null) {
        Uint8List? dataBytes;

        if (kIsWeb) {
          dataBytes = result.files.first.bytes;
        } else {
          File file = File(result.files.first.path ?? "");
          dataBytes = await file.readAsBytes();
        }

        // check image size within 5mb
        int imageSize = ((result.files.first.size / 1024) / 1024).round();

        if (imageSize > 5) {
          _imageOverSizeAlert(context: context);
        }

        if (dataBytes != null && imageSize <= 5) {
          String? _extension;
          if (result != null) {
            PlatformFile file = result.files.first;
            _extension = file.extension;
          }

          String _imageBase64 = base64Encode(dataBytes);
          onUpload!(
              image: _imageBase64.toImage(),
              imageBase64: _imageBase64,
              extension: _extension ?? "png");
        }
      }
      // ignore: nullable_type_in_catch_clause
    } on PlatformException catch (e) {
      print("_browseImageExplorer PlatformException e====${e.toString()}");
    }
  }
}

class _HolePainter extends CustomPainter {
  final double height;
  _HolePainter({required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black54;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addRRect(
              RRect.fromLTRBR(0, 0, size.width, height, Radius.circular(0))),
        Path()
          ..addOval(Rect.fromCircle(
              center: Offset(size.width / 2, height / 2), radius: height / 2))
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
