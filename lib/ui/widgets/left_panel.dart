import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:viking_game/models/game.dart';
import 'package:viking_game/models/player.dart';
import 'package:viking_game/providers/appdata.dart';
import 'package:viking_game/services/game.service.dart';
import 'package:viking_game/ui/widgets/bordered-dropdown.dart';
import 'package:viking_game/ui/widgets/players_lists.dart';
import 'package:viking_game/ui/widgets/vkcounter.dart';
import 'package:viking_game/utilities/constants.dart';
import 'package:viking_game/utilities/enums.dart';
import 'package:viking_game/utilities/sharedpref.dart';
import 'package:wakelock/wakelock.dart';

class LeftPanel extends StatefulWidget {
  const LeftPanel({Key? key}) : super(key: key);

  @override
  _LeftPanelState createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> {
  StopWatchTimer? _stopWatchTimer;
  Color timerColor = Colors.white;
  List<DropdownMenuItem> _gamesList = [];
  late List<Game> games;
  late List<Player> players = [];
  late Game selectedGame;
  late int selectedEnumGameId = -1;
  String? selectedGameId;

  Future<void> logout() async {
    await SharedPrefrencesHelper.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, PageRoutes.loginScreen, (route) => false);
  }

  Future<void> initializeStopWatcher() async {
    int? sessionTime = await SharedPrefrencesHelper.getSessionTime();
    _stopWatchTimer = StopWatchTimer(
        mode: StopWatchMode.countDown,
        presetMillisecond: sessionTime * 60 * 1000,
        onEnded: () async {
          await SharedPrefrencesHelper.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, PageRoutes.loginScreen, (route) => false);
        });
    Wakelock.enable();

    setState(() {});
    await Future.delayed(Duration(seconds: 10));

    _stopWatchTimer!.onExecute.add(StopWatchExecute.start);
    initializePlayer(new Player(name: 'Player 1'));
  }

  Future<void> loadGames() async {
    games = await GameService.getGames();
    setState(() {
      _gamesList = Game.buildMenuItem(games);
    });
  }

  void editPlayer(int index, String name) {
    players[index].name = name;
    setState(() {});
  }

  void initializePlayer(Player _player) {
    Provider.of<AppData>(context, listen: false).initializePlayer(_player);
  }

  @override
  void initState() {
    super.initState();
    loadGames();
    initializeStopWatcher();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, value, child) => Sizer(
        builder: (context, orientation, deviceType) {
          bool isWide = (deviceType == DeviceType.tablet &&
                  orientation == Orientation.landscape) ||
              deviceType == DeviceType.web;
          return Container(
            width: isWide ? 41.w : 20.w,
            color: kPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20.47, vertical: 30.1),
            child: ListView(
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  height: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    )),
                    Text(
                      ' TIME ',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontFamily.BaiJamjureeMedium,
                          fontSize: 16),
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    ))
                  ],
                ),
                _stopWatchTimer != null
                    ? StreamBuilder<int>(
                        stream: _stopWatchTimer!.rawTime,
                        initialData: _stopWatchTimer!.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data;
                          final displayTime = StopWatchTimer.getDisplayTime(
                              value!,
                              milliSecond: false);
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  displayTime,
                                  style: TextStyle(
                                    color:
                                        _stopWatchTimer!.minuteTime.value >= 1
                                            ? Colors.white
                                            : Colors.red,
                                    fontSize: 25,
                                    fontFamily: FontFamily.BaiJamjureeBold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                    : Container(),
                SizedBox(
                  height: 15,
                ),
                BorderedDropdown(
                  width: 328,
                  list: _gamesList,
                  hint: 'Select Game',
                  onChanged: (val) {
                    setState(
                      () {
                        selectedGameId = games
                            .firstWhere((element) => element.gameId == val)
                            .id;
                        Provider.of<AppData>(context, listen: false)
                            .setSelectedGame(val, selectedGameId!);
                        selectedEnumGameId = val;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Number of players',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: FontFamily.BaiJamjureeMedium,
                      ),
                    ),
                    VKCounter(
                      initialValue: 1,
                      maxValue: 10,
                      minValue: 1,
                      step: 1,
                      onChanged: (val) async {
                        if (value.players.length < val) {
                          value.initializePlayer(
                              new Player(name: 'Player $val'));
                          // players.add(new Player(name: 'Player $val'));
                        } else if (value.players.length > 1) {
                          Provider.of<AppData>(context).removePlayer(val);
                        }
                        // Future.delayed(Duration(milliseconds: 500));
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Text(
                  'Choose Player',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.BaiJamjureeMedium,
                      fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),
                PlayersList(
                  players: value.players,
                  onEdit: (index, name) => editPlayer(index, name),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
