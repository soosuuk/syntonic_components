import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum SsoType {
  apple,
  google,
}

class SsoButton extends StatelessWidget {
  SvgPicture appleIcon = SvgPicture.asset(
    "assets/images/apple_icon.svg",
    width: 32,
    height: 32,
  );
  SvgPicture googleIcon = SvgPicture.asset(
    "assets/images/google_icon.svg",
    width: 32,
    height: 32,
  );
  String appleText = "apple";
  String googleText = "google";
  final SsoType ssoType;
  final VoidCallback onTap;

  SsoButton.apple({super.key, required this.onTap})
      : ssoType = SsoType.apple;

  SsoButton.google({super.key, required this.onTap})
      : ssoType = SsoType.google;

  SsoButton._({required this.ssoType, required this.onTap});

  @override
  Widget build(BuildContext context) {
    switch (ssoType) {
      case SsoType.apple:
        return createButton(Colors.black, appleIcon, appleText, onTap);
      case SsoType.google:
      default:
        return createButton(Colors.white, googleIcon, googleText, onTap);
    }
  }

  Widget createButton(Color buttonColor, SvgPicture buttonImage,
      String buttonText, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withAlpha(24),
            width: 1.0,
          ),
          color: Colors.white,
          // borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: buttonImage,
        ),
      ),
    );
  }
}
