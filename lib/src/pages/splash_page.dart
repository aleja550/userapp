import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:userapp/src/pages/welcome_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 7,
      backgroundColor: Color(0xFFFEDD7C),
      image: Image.asset('assets/loader.gif'),
      loaderColor: Colors.white,
      photoSize: 50.0,
      navigateAfterSeconds: WelcomePage(),
    );
  }
}