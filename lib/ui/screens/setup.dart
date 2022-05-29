import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:viking_game/models/game_session.dart';
import 'package:viking_game/models/vuser.dart';
import 'package:viking_game/services/game.service.dart';
import 'package:viking_game/ui/widgets/bordered-dropdown.dart';
import 'package:viking_game/ui/widgets/filled_button.dart';
import 'package:viking_game/ui/widgets/progress_dialog.dart';
import 'package:viking_game/utilities/common-lists.dart';
import 'package:viking_game/utilities/constants.dart';
import 'package:viking_game/utilities/custom_exception.dart';
import 'package:viking_game/utilities/sharedpref.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  var _key = GlobalKey<FormState>();

  Future<void> createSession() async {
    if (_key.currentState!.validate()) {
      VUser user = await SharedPrefrencesHelper.getUserInfo();
      GameSession session =
          new GameSession(userId: user.id!, time: selectedTime);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(message: 'Starting session ...');
          });
      try {
        GameService.createGameSession(session).then((value) {
          Navigator.pop(context);
          SharedPrefrencesHelper.setSessionTime(value.time);
          Navigator.pushNamedAndRemoveUntil(
              context, PageRoutes.homeScreen, (route) => false);
        });
      } on CustomException catch (e) {
        Navigator.pop(context);
      }
    }
  }

  int selectedTime = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Form(
        key: _key,
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Set time for the session:',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: FontFamily.BaiJamjureeBold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  BorderedDropdown(
                      list: gameTime,
                      hint: 'Set Game Time',
                      isRequired: true,
                      width: 250,
                      onChanged: (val) {
                        setState(() {
                          selectedTime = val;
                        });
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 200,
                    child: FilledButton(
                      text: 'Start Session',
                      onPressed: () => createSession(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
