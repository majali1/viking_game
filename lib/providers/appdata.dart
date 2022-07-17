import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:viking_game/models/game_scores.dart';
import 'package:viking_game/models/game_session.dart';
import 'package:viking_game/models/player.dart';
import 'package:viking_game/models/vuser.dart';
import 'package:viking_game/utilities/sharedpref.dart';

class AppData extends ChangeNotifier {
  AppData() {
    getCurrentUserInfo();
  }

  VUser? user;
  int? selectedGame = -1;
  String? selectedGameId;

  GameSession? gameSession;

  List<GameScore> gameScores = [];
  late List<Player> players = [];


  void initializePlayer(Player _player){
    players.add(_player);
    int scoreIndex = players.length - 1;
    gameScores.add(new GameScore(index: scoreIndex, scores: [0]));
    notifyListeners();
  }

  void removePlayer(int index){
    players.removeAt(index);
    notifyListeners();
  }

  void setSelectedGame(int _selectedGame, String _selectedGameId) {
    selectedGame = _selectedGame;
    selectedGameId = _selectedGameId;
    notifyListeners();
  }

  void setSelectedGameId(String _id){
    selectedGameId = _id;
    notifyListeners();
  }

  int getSelectedGame() {
    return selectedGame!;
  }

  Future<void> getCurrentUserInfo() async {
    VUser currentUser = await SharedPrefrencesHelper.getUserInfo();
    updateUserInfo(currentUser);
  }

  void updateUserInfo(VUser _user) {
    user = _user;
    notifyListeners();
  }
}
