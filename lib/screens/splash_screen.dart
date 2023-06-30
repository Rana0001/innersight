import 'dart:async';

import 'package:flutter/material.dart';

import './get_started_screen.dart';

import '../widgets/background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool display = false;
  late Timer _timer;
  late Timer _timer2;

  @override
  void initState() {
    super.initState();

    _timer =
        Timer(const Duration(seconds: 3), () => setState(() => display = true));
    _timer2 = Timer(const Duration(seconds: 5), () => navigator());
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _timer2.cancel();
  }

  void navigator() {
    Navigator.of(context).pushNamed(GetStartedScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackGround(
          shadowTop: true,
          widget:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Spacer(),
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 10),
            const Text(
              'Inner Sight',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            if (display)
              const CircularProgressIndicator(
                color: Color(0xff45b3cb),
              ),
            const Spacer(),
            const SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }
}
