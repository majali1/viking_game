import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:viking_game/providers/appdata.dart';
import 'package:viking_game/ui/screens/home.dart';
import 'package:viking_game/ui/screens/login.dart';
import 'package:viking_game/ui/screens/setup.dart';
import 'package:viking_game/ui/screens/splash.dart';
import 'package:viking_game/utilities/constants.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(Duration(seconds: 5), () {
    FlutterNativeSplash.remove();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      builder: (context, child) {
        return MaterialApp(
          title: 'Vikings (Admin)',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          initialRoute: PageRoutes.splashScreen,
          routes: {
            PageRoutes.splashScreen: (context) => SplashScreen(),
            PageRoutes.loginScreen: (context) => LoginScreen(),
            PageRoutes.homeScreen: (context) => HomeScreen(),
            PageRoutes.setupScreen: (context) => SetupScreen()
          },
        );
      },
    );
  }
}