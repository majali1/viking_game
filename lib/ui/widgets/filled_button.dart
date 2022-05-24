import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:viking_game/utilities/constants.dart';

class FilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FilledButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Container(
        width: 99.h,
        height: 56,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: kPrimaryButtonColor),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontFamily: FontFamily.BaiJamjureeSemiBold,
                fontSize: 16),
          ),
        ),
      );
    });
  }
}
