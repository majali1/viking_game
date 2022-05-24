import 'package:flutter/foundation.dart';
import 'package:viking_game/models/vuser.dart';
import 'package:viking_game/utilities/sharedpref.dart';

class AppData extends ChangeNotifier {
  AppData() {
    getCurrentUserInfo();
  }

  VUser? user;
  int? selectedGame;

  void setSelectedGame(int _selectedGame) {
    selectedGame = _selectedGame;
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
