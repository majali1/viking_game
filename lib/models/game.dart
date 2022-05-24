import 'package:flutter/material.dart';
import 'package:viking_game/utilities/constants.dart';

class Game {
  final String name;
  final int gameId;
  final String id;

  Game({required this.name, required this.id, required this.gameId});

  factory Game.fromJson(Map json) {
    return Game(id: json['_id'], gameId: json['id'], name: json['name']);
  }

  static List<DropdownMenuItem<int>> buildMenuItem(List<Game> games) {
    return games
        .map((e) => DropdownMenuItem(
              child: Text(
                e.name,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: FontFamily.BaiJamjureeMedium,
                    fontSize: 16),
              ),
              value: e.gameId,
            ))
        .toList();
  }
}
