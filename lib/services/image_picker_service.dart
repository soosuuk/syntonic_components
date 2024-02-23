import 'dart:io';

import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final picker = ImagePicker();

  // ImagePickerService._internal();
  //
  // factory ImagePickerService() {
  //   return _instance;
  // }

  Future<File?> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }

  Future<File?> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return null;
    }

    return  File(pickedFile.path);
  }
}
