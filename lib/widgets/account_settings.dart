import 'package:flutter/material.dart';
import 'package:innersight/screens/change_password_screen.dart';
import 'package:innersight/screens/profile_screen.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);
  final List<Map> _content = const [
    {
      'color': Color(0xff56CCF2),
      'icon': Icons.person,
      'title': 'Profile',
      'screen': ProfileScreen(),
    },
    {
      'color': Color(0xffEB5757),
      'icon': Icons.lock,
      'title': 'Change Password',
      'screen': ChangePasswordScreen(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Account settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xff677294),
          ),
        ),
        const SizedBox(height: 5),
        Column(
          children: _content.map((e) {
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: e['color'],
                    child: Icon(e['icon'], color: Colors.white, size: 17),
                  ),
                  title: Text(
                    e['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff677294),
                    ),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => e['screen']),
                    );
                  },
                ),
                Divider(
                  color: const Color(0xff677294).withOpacity(0.2),
                  thickness: 1,
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
