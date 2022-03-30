import 'package:beaconstac_app/analytics1.dart';
import 'package:beaconstac_app/logic/subLogics/Orientation.dart';
import 'package:beaconstac_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenApp extends StatefulWidget {
  SplashScreenApp({Key? key}) : super(key: key);

  @override
  State<SplashScreenApp> createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  @override
  Widget build(BuildContext context) {
    portraitModeOnly();
    return SplashScreen(
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.lightBlue[200] ?? Colors.blue,
            Colors.lightBlue[400] ?? Colors.blue,
            Colors.lightBlue[700] ?? Colors.blue,
          ],
        ),
        seconds: 3,
        photoSize: 150,
        backgroundColor: Colors.white,
        image: Image.asset('images/beaconstac.png'),
        loaderColor: Colors.white,
        navigateAfterSeconds: Homepage());
  }
}
