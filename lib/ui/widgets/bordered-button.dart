import 'package:flutter/material.dart';
import 'package:viking_game/utilities/constants.dart';

class BorderedButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onPressed;

  const BorderedButton({Key? key, required this.text, required this.onPressed, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: FontFamily.BaiJamjureeSemiBold),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
