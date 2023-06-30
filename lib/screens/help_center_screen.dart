import 'package:flutter/material.dart';
import 'package:innersight/screens/components/bot_body.dart';
import 'package:innersight/screens/components/constants.dart';
import 'package:innersight/screens/tabs_screen.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});
  static String routeName = "/helpCenter";
  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreen();
}

class _HelpCenterScreen extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const BotBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const TabsScreen()),
                  (route) => false);
            },
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/chat/bot_avatar.png'),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Virtual Assistance', style: TextStyle(fontSize: 16)),
              Text('Always Active', style: TextStyle(fontSize: 12))
            ],
          )
        ],
      ),
    );
  }
}
