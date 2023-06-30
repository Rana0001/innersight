import 'package:flutter/material.dart';
import 'package:innersight/screens/tabs_screen.dart';

import '../widgets/background.dart';
import '../widgets/account_settings.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = './settings-route';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 48,
        leadingWidth: 48,
        title: const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )),
        leading: Container(
          height: 30,
          width: 30,
          margin: const EdgeInsets.only(left: 16, top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () =>
                Navigator.of(context).popAndPushNamed(TabsScreen.routeName),
            padding: const EdgeInsets.only(left: 7),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 13,
              color: Color(0xff677294),
            ),
          ),
        ),
      ),
      body: const SafeArea(
        child: BackGround(
          shadowTop: true,
          widget: SingleChildScrollView(
            primary: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountSettings(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
