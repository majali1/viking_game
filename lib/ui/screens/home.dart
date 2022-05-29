import 'package:flutter/material.dart';
import 'package:viking_game/ui/widgets/left_panel.dart';
import 'package:viking_game/ui/widgets/right_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Row(
          children: [LeftPanel(),
            Expanded(child:
            RightPanel())],
        ),
      ),
    );
  }
}
