import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  // Add Shared Preferences
  setSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTime', false);
  }

  String? email;
  String? password;

  getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTime = prefs.getBool('isFirstTime');
    email = prefs.getString('email');
    password = prefs.getString('password');
    if (isFirstTime != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(
                email: email!,
                password: password!,
              )));
    }
  }

  final List<String> _pictures = [
    'assets/images/trust-doc.jpg',
    'assets/images/best-doc.jpg',
    'assets/images/easy-appoint.jpg'
  ];
  var _index = 0;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SizedBox(
      width: mediaQuery.width,
      height: mediaQuery.height,
      child: Column(children: [
        const Spacer(),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage:
              AssetImage(_index > 2 ? _pictures[2] : _pictures[_index]),
          radius: 168,
        ),
        const Spacer(),
        Text(
          _index == 0
              ? 'Find Trusted Doctors'
              : _index == 1
                  ? 'Choose Best Doctors'
                  : 'Easy Appointments',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _index == 0
                ? "Discover experienced psychotherapists in your area and read patient reviews to find the perfect match for your mental health needs."
                : _index == 1
                    ? "Compare qualifications, specialties, and treatment approaches of top psychotherapists to make an informed decision for your mental well-being."
                    : 'Book therapy sessions effortlessly with our user-friendly scheduling system, ensuring convenient access to professional help when you need it most.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff677294),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _index++;
            });
            if (_index > 2) {
              Navigator.of(context).pushNamed(AuthScreen.routeName);
            }
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(289, 54),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            _index == 0 ? 'Get Started' : 'Next',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AuthScreen.routeName);
          },
          child: const Text(
            'Skip',
            style: TextStyle(
              color: Color(0xff677294),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ]),
    );
  }
}
