import 'dart:async';
import 'package:credit_card_ml/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
            () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const MainScreen(),
            ),
          );
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                child: Lottie.asset('assets/ai_splash_screen.json'),),
            ),
            Center(
              child: Opacity(
                opacity: .8,
                child: Image.asset('assets/ash_dev.png',  width: MediaQuery
                    .of(context)
                    .size
                    .width / 4,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 4,),
              ),
            )
          ],
        )
    );
  }
}
