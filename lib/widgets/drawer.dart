import 'package:flutter/material.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/screens/all_records_screen.dart';
import 'package:innersight/screens/auth_screen.dart';
import 'package:innersight/services/services.dart';

import '../screens/help_center_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/profile_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isLoading = false;

  signOut() async {
    setState(() {
      _isLoading = true;
    });
    bool value = await Services().logout(context);
    if (value) {
      setState(() {
        _isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthScreen()),
            (route) => false);
      });
    }
  }

  void _showErrorDialog(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: const Text('Log Out',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff677294))),
                content: const Text('Are you sure you want to logout?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff677294))),
                actions: [
                  TextButton(
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: theme.primary)),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      }),
                  TextButton(
                      child: Text("Ok",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: theme.primary)),
                      onPressed: () {
                        signOut();
                      })
                ]));
  }

  Widget buildListTile(IconData icon, String title, VoidCallback tapHandler,
      BuildContext context) {
    return SizedBox(
        width: 250,
        height: 61,
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          onTap: tapHandler,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Constant().dimension(context);
    final theme = Theme.of(context).colorScheme;
    return _isLoading
        ? SizedBox(
            height: Constant.height,
            width: Checkbox.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: theme.primary,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Logging Out...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        : Drawer(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff45b3cb),
                    Color(0xff1c9ab6),
                  ],
                ),
              ),
              child: RawScrollbar(
                  thumbColor: Colors.white,
                  thickness: 5,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(ProfileScreen.routeName);
                          },
                          leading: Constant.patient.profileUrl != ""
                              ? CircleAvatar(
                                  radius: 22,
                                  backgroundImage: NetworkImage(
                                      Constant.patient.profileUrl!),
                                )
                              : const CircleAvatar(
                                  radius: 22,
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.png'),
                                ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              '${Constant.patient.firstName} ${Constant.patient.lastName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          subtitle: Row(children: [
                            const Icon(
                              Icons.phone,
                              size: 15,
                              color: Colors.white,
                            ),
                            Text(
                              Constant.patient.phone != ""
                                  ? " +977 ${Constant.patient.phone}"
                                  : ' +977 9XXXXXXXXX',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ]),
                          trailing: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close))),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        buildListTile(Icons.paste_outlined, 'Medical Records',
                            () {
                          Navigator.of(context)
                              .pushReplacementNamed(AllRecordsScreen.routeName);
                        }, context),
                        buildListTile(Icons.help_outline, 'Help Center', () {
                          Navigator.of(context)
                              .pushReplacementNamed(HelpCenterScreen.routeName);
                        }, context),
                        buildListTile(Icons.settings_rounded, 'Settings', () {
                          Navigator.of(context)
                              .pushReplacementNamed(SettingsScreen.routeName);
                        }, context),
                        const SizedBox(height: 30),
                        buildListTile(Icons.logout, 'Logout',
                            () => _showErrorDialog(context), context),
                      ],
                    ),
                  )),
            ),
          );
  }
}
