import 'dart:ui';
import 'package:flutter/material.dart';

class SyntonicCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SyntonicCloseButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: InkWell(onTap: onPressed ?? () => Navigator.of(context).maybePop(), child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xA6000000), // #000000 at 65% opacity
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(size: 20, Icons.close, color: Colors.white, weight: 0.1,),
        ),),
      ),
    );
  }
}
