import 'package:flutter/material.dart';
import 'package:viking_game/utilities/constants.dart';

class ProgressDialog extends StatelessWidget {
  final String message;

  ProgressDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 6.0,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF285678)),
            ),
            const SizedBox(
              width: 26.0,
            ),
            Text(
              message,
              style: const TextStyle(
                  fontFamily: FontFamily.BaiJamjureeMedium,
                  fontSize: 18,
                  color: Color(0xFF474747)),
            )
          ],
        ),
      ),
    );
  }
}
