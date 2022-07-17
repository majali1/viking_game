import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:viking_game/models/game_attribute.dart';
import 'package:viking_game/services/game.service.dart';
import 'package:viking_game/utilities/constants.dart';

class Bullseye extends StatelessWidget {
  final String gameId;

  Bullseye({Key? key, required this.gameId}) : super(key: key);
  late GameAttribute gameAttribute;
  List<GamePoint> gamePoints = [];

  Future<List<GamePoint>> loadGameAttribute() async {
    GameAttribute? _gameAttribute = await GameService.getGameAttributes(gameId);
    if (_gameAttribute == null) {
      gamePoints.add(GamePoint(
          index: 1, layer: Color(0xFFCF2233).value.toString(), score: 100));
      gamePoints.add(GamePoint(
          index: 2, layer: Color(0xFFFAE80B).value.toString(), score: 100));
      gamePoints.add(GamePoint(
          index: 3, layer: Color(0xFF35C030).value.toString(), score: 100));
      gamePoints.add(GamePoint(
          index: 4, layer: Color(0xFF3A8AFA).value.toString(), score: 100));
      gamePoints.add(
          GamePoint(index: 5, layer: Colors.pink.value.toString(), score: 100));
      gameAttribute =
          new GameAttribute(gameId: gameId, isGlobal: true, points: gamePoints);

      return gamePoints;
    } else {
      gameAttribute = _gameAttribute;
      return gameAttribute.points;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Container(
        height: 500,
        child: FutureBuilder(
          future: loadGameAttribute(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Alert(
                context: context,
                title: 'Error (Bullseye specs)',
                desc: 'Error while fetching game attribute',
                type: AlertType.error,
                buttons: [
                  DialogButton(
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: kPrimaryColor,
                    width: 120,
                  ),
                ],
              ).show();
            }

            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    (snapshot.data as List).length > 0
                ? buildBullseye(context, 1)
                : Container();
          },
        ),
      ),
    );
  }

  Widget buildBullseye(BuildContext context, int index) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              height: 425,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                      int.parse(gameAttribute.points[4].layer.toString()))),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                      int.parse(gameAttribute.points[3].layer.toString()))),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              height: 275,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                      int.parse(gameAttribute.points[2].layer.toString()))),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                      int.parse(gameAttribute.points[1].layer.toString()))),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              height: 125,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                      int.parse(gameAttribute.points[0].layer.toString()))),
            ),
          ),
        )
      ],
    );
  }
}
