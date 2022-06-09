import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:viking_game/models/player.dart';
import 'package:viking_game/providers/appdata.dart';
import 'package:viking_game/utilities/constants.dart';

class VPlayersNames extends StatelessWidget {
  final List<Player> players;

  const VPlayersNames({Key? key, required this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Container(
          padding: EdgeInsets.only(top: 15),
          height: 150,
          child: RotatedBox(
            quarterTurns: 1,
            child: ListView.builder(
              itemBuilder: _buildPlayerItem,
              itemCount: players.length,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayerItem(BuildContext context, int index) {
    return Text(
      players[index].name!,
      style: TextStyle(
          fontSize: 17,
          fontFamily: FontFamily.BaiJamjureeBold,
          color: Colors.white),
    );
  }
}
