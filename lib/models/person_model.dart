import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:flutter/widgets.dart';

class PersonModel {
  final String? id;
  final String? email;
  final String? name;
  final String? photoUrl;
  final bool isEnabled;

  const PersonModel({
    this.id,
    this.email,
    this.name,
    this.photoUrl,
    this.isEnabled = true,
  });

  // /// Get a [PersonModel] for dummy.
  // factory PersonModel.dummy() {
  //   return PersonModel(
  //     id: BigInt.from(1),
  //     gender: GenderType.Male
  //   );
  // }

  // /// Convert from another [PersonModel].
  // /// Typically convert to [PersonModel] from extended Model.
  // PersonModel.convertFrom(PersonModel person) {
  //   id = person.id;
  //   image = person.image;
  //   imageBase64 = person.imageBase64;
  //   name = person.name;
  //   gender = person.gender;
  // }

  /// Get avatar color, depends on [id].
  Color getCustomerColor({required int id}) {
    switch (id) {
      case 0:
        return SyntonicColor.torch_red;
      case 1:
        return SyntonicColor.orange;
      case 2:
        return SyntonicColor.yellow;
      case 3:
        return SyntonicColor.yellow_green;
      case 4:
        return SyntonicColor.lime_green;
      case 5:
        return SyntonicColor.primary_color;
      case 6:
        return SyntonicColor.cornflower_blue;
      case 7:
        return SyntonicColor.electric_purple;
      case 8:
        return SyntonicColor.pink;
      case 9:
        return SyntonicColor.black88;
      default:
        return SyntonicColor.primary_color;
    }
  }

  static Image? imageFromJson(String? value) {
    return null;

    // /// FIXME: There are contained two cases (URL/Base 64). This is bad solution.
    // if (value != null) {
    //   if (value.contains(RegExp(r'https?:\/\/'))) {
    //     return Image.network(value);
    //   } else {
    //     return value.toImage();
    //   }
    // } else {
    //   return null;
    // }
  }

  static String? imageToJson(Image? json) {
    return null;
  }

  static String? nameFromJson(String? value) {
    return value;
  }

  static String? nameToJson(String? value) {
    return value;
  }
}
