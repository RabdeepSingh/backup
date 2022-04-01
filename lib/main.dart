import 'package:beaconstac_app/analytics.dart';
import 'package:beaconstac_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Beaconstac App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 28.0,
                  color: Color.fromARGB(255, 64, 61, 61),
                  fontWeight: FontWeight.w500),
              headline3: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
              bodyText1: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500),
              bodyText2: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
              caption: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 15.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
              // body1: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500),
            ),
      ),
      // home: SplashScreenApp(),
      home: Homepage(),
    );
  }
}
