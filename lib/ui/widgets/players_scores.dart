import 'package:flutter/material.dart';
import 'package:viking_game/models/game_scores.dart';
import 'package:viking_game/utilities/constants.dart';

class PlayersScores extends StatelessWidget {
  final List<GameScore> gameScores;

  const PlayersScores({Key? key, required this.gameScores}) : super(key: key);

  int getRoundsNo() {
    int count = 0;
    gameScores.forEach((_gameScore) {
      if (_gameScore.scores.length > count) {
        count = _gameScore.scores.length;
      }
    });
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(
          getRoundsNo(),
          (index) => RotatedBox(
            quarterTurns: 1,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5,),
                Text(
                  'Round ${index + 1}',
                  style: TextStyle(
                      fontFamily: FontFamily.BaiJamjureeBold,
                      fontSize: 14,
                      color: Colors.white),
                ),

                for(int i = 0; i < gameScores.length; i++)
                  Text('${gameScores[i].scores[0]}',
                    style: TextStyle(
                        fontFamily: FontFamily.BaiJamjureeBold,
                        fontSize: 16,
                        color: Colors.white),
                  ),

                // Container(
                //   alignment: Alignment.topCenter,
                //   padding: EdgeInsets.zero,
                //   height: 70,
                //   child: ListView.builder(
                //             itemBuilder: _itemScoreBuild,
                //             itemCount: gameScores.length),
                // )
              ],
            ),
          ),
        ),
      ),
      // RotatedBox(
      //     quarterTurns: 1,
      //     child: ListView.builder(
      //         itemBuilder: _itemScoreBuild,
      //         itemCount: gameScores.length)),
    );
  }

  Widget _itemScoreBuild(BuildContext context, int index) {
    return Text('${gameScores[index].scores[0]}',
          style: TextStyle(
              fontFamily: FontFamily.BaiJamjureeBold,
              fontSize: 16,
              color: Colors.white),
    );
  }
}
