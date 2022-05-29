import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:viking_game/models/player.dart';
import 'package:viking_game/ui/widgets/edit_player.dart';
import 'package:viking_game/utilities/constants.dart';

class PlayersList extends StatefulWidget {
  final List<Player> players;
  final Function onEdit;

  const PlayersList({Key? key, required this.players, required this.onEdit})
      : super(key: key);

  @override
  _PlayersListState createState() => _PlayersListState();
}

class _PlayersListState extends State<PlayersList> {
  int selectedPlayer = 0;

  void setSelectedPlayer(int val) {
    setState(() {
      selectedPlayer = val;
    });
  }

  void editPlayer(int index, String name) async {
    await showDialog<String>(
      barrierColor: Color(0x29000000),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) => new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: EditPlayer(
              name: name,
            ),
          ),
        ),
      ),
    ).then((value) {
      if (value != null) {
        widget.onEdit(index, value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        itemBuilder: _buildPlayerItem,
        itemCount: widget.players.length,
      ),
    );
  }

  Widget _buildPlayerItem(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: RadioListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            value: index,
            groupValue: selectedPlayer,
            onChanged: (val) {
              setSelectedPlayer(val as int);
            },
            title: Text(
              widget.players[index].name!,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamily.BaiJamjureeMedium,
                  fontSize: 16),
            ),
          ),
        ),
        IconButton(
          onPressed: () => editPlayer(index, widget.players[index].name!),
          icon: Container(
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 17,
            ),
          ),
        ),
      ],
    );
  }
}
