import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResultPanel extends StatelessWidget {

  const ResultPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Container(
        width: 720,
        padding: EdgeInsets.symmetric(vertical: 13),
        color: Color(0xFF113F50),
        child: Row(
          children: [

          ],
        ),
      ),
    );
  }
}
