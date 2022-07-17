import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:viking_game/providers/appdata.dart';
import 'package:viking_game/ui/widgets/games/bullseye.dart';
import 'package:viking_game/ui/widgets/results_panel.dart';
import 'package:viking_game/utilities/constants.dart';
import 'package:viking_game/utilities/enums.dart';
import 'package:viking_game/utilities/sharedpref.dart';

class RightPanel extends StatefulWidget {
  const RightPanel({Key? key}) : super(key: key);

  @override
  _RightPanelState createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  bool showBGImage = true;
  late int selectedEnumGameId = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, value, child) => Sizer(
        builder: (context, orientation, deviceType) {
          bool isWide = (deviceType == DeviceType.tablet &&
                  orientation == Orientation.landscape) ||
              deviceType == DeviceType.web;

          return Container(
              child: Row(
            children: [
              Visibility(
                visible: value.selectedGame == -1,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/axe.svg'),
                      Text(
                        'Select Game to Edit',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: FontFamily.BaiJamjureeMedium),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                maintainState: false,
                visible: value.selectedGame == GamesEnum.Bullseye.value,
                child: Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: value.selectedGameId != null
                        ? Bullseye(gameId: value.selectedGameId!)
                        : Container(),
                  ),
                ),
              ),
              ResultPanel(
                players: value.players,
                gameScores: value.gameScores,
              ),
            ],
          ));
        },
      ),
    );
  }
}
