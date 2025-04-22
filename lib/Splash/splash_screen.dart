import 'package:flutter/material.dart';

import '../Home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          )),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/Splash Screen.png',
      fit: BoxFit.cover,
    );
  }
}
