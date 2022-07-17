import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:viking_game/models/game_scores.dart';
import 'package:viking_game/models/player.dart';
import 'package:viking_game/ui/widgets/players_scores.dart';
import 'package:viking_game/ui/widgets/vplayers_names.dart';

class ResultPanel extends StatelessWidget {
  final List<Player> players;
  final List<GameScore> gameScores;

  const ResultPanel({Key? key, required this.players, required this.gameScores})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Container(
        width: 120,
        height: 600,
        padding: EdgeInsets.symmetric(vertical: 13),
        color: Color(0xFF113F50),
        child: Column(
          children: [
            VPlayersNames(
              players: players,
            ),
            Divider(
              color: Colors.white,
              height: 20,
              indent: 10,
              endIndent: 10,
            ),
            PlayersScores(
              gameScores: gameScores,
            )
          ],
        ),
      ),
    );
  }
}
