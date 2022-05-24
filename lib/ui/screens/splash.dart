import 'package:flutter/material.dart';
import 'package:viking_game/utilities/constants.dart';
import 'package:viking_game/utilities/sharedpref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkLoggedInUser() async {
    if (await SharedPrefrencesHelper.getToken() == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, PageRoutes.loginScreen, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, PageRoutes.homeScreen, (route) => false);
    }
  }

  @override
  void initState() {
    checkLoggedInUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/bg.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
