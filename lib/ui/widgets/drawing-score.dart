import 'package:flutter/material.dart';
import 'package:viking_game/models/game_attribute.dart';
import 'package:viking_game/utilities/constants.dart';

class DrawingScore extends StatelessWidget {
  final GamePoint gamePoint;

  const DrawingScore({Key? key, required this.gamePoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 35,
          padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: kPrimaryColor),
          child: Text(
            gamePoint.score.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontFamily: FontFamily.BaiJamjureeMedium,
            ),
          ),
        ),
        ClipPath(
          clipper: TriangleClipper(),
          child: Container(
            color: kPrimaryColor,
            height: 10,
            width: 15,
          ),
        ),
      ],
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
