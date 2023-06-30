import 'package:flutter/material.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/component/message.dart';
import 'package:innersight/screens/settings_screen.dart';
import 'package:innersight/screens/tabs_screen.dart';
import 'package:innersight/services/services.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isObsecured = true;
  bool _isObsecured2 = true;
  bool _isObsecured3 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const TabsScreen()),
                (route) =>
                    false); // Navigate to the SettingsScreen when the back button is pressed
          },
        ),
        title: const Text('Change Password'),
      ),
      body: Form(
        // key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 50),
              const Text('Change Your Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 70),
              TextFormField(
                controller: _passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _isObsecured,
                decoration: InputDecoration(
                  suffixIcon: !_isObsecured
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecured = !_isObsecured;
                            });
                          },
                          icon: const Icon(Icons.visibility_rounded))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecured = !_isObsecured;
                            });
                          },
                          icon: const Icon(Icons.visibility_off)),
                  hintText: 'Current Password',
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff677294)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                        color: const Color(0xff677294).withOpacity(0.16)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                        color: const Color(0xff677294).withOpacity(0.16)),
                  ),
                ),
                keyboardType: TextInputType.text,
                onSaved: (newValue) {
                  _passwordController.text = newValue!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _isObsecured2,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  suffixIcon: !_isObsecured2
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecured2 = !_isObsecured2;
                            });
                          },
                          icon: const Icon(Icons.visibility_rounded))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecured2 = !_isObsecured2;
                            });
                          },
                          icon: const Icon(Icons.visibility_off)),
                  hintText: 'New Password',
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff677294)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                        color: const Color(0xff677294).withOpacity(0.16)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                        color: const Color(0xff677294).withOpacity(0.16)),
                  ),
                ),
                keyboardType: TextInputType.text,
                onSaved: (newValue) {
                  _newPasswordController.text = newValue!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _cPasswordController,
                obscureText: _isObsecured3,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  suffixIcon: !_isObsecured3
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecured3 = !_isObsecured3;
                            });
                          },
                          icon: const Icon(Icons.visibility_rounded))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecured3 = !_isObsecured3;
                            });
                          },
                          icon: const Icon(Icons.visibility_off)),
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff677294)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                        color: const Color(0xff677294).withOpacity(0.16)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                        color: const Color(0xff677294).withOpacity(0.16)),
                  ),
                ),
                keyboardType: TextInputType.text,
                onSaved: (newValue) {
                  _cPasswordController.text = newValue!;
                },
              ),
              const SizedBox(height: 20),
              Container(
                height: 54,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (_cPasswordController.text ==
                        _newPasswordController.text) {
                      await Services()
                          .changePassword(
                              Constant.patient.email!,
                              _passwordController.text,
                              _newPasswordController.text,
                              context)
                          .then((value) => setState(() {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    SettingsScreen.routeName,
                                    (Route<dynamic> route) => route.isFirst);
                              }));
                    } else {
                      Messages.errorMessage(
                          "New Password and Confirm Password is not Match.",
                          context);
                    }
                  },
                  child: const Text(
                    'Update Password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ]),
          ),
        ),
      ),
    );
  }
}
