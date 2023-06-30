import 'package:flutter/material.dart';
import 'package:innersight/component/message.dart';
import 'package:innersight/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/tabs_screen.dart';

import './google_facebook_card.dart';
import './bottom_sheet.dart' as bt;

class SignIn extends StatefulWidget {
  SignIn({Key? key, this.password, this.email}) : super(key: key);
  String? password;
  String? email;
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.email != null) {
      _emailController.text = widget.email!;
    }
    if (widget.password != null) {
      _passwordController.text = widget.password!;
    }
  }

  _loginWithGoogle() async {
    setState(() {
      isLoading = true;
    });
    bool result = await Services().loginWithGoogle(context);
    if (result) {
      setState(() {
        isLoading = false;
        Navigator.pushReplacementNamed(context, TabsScreen.routeName);
        Messages.successMessage("Login Successful", context);
      });
    } else {
      setState(() {
        isLoading = false;
        Messages.errorMessage("Login Failed", context);
      });
    }
  }

  setSharedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', _emailController.text);
    sharedPreferences.setString('password', _passwordController.text);
  }

  _loginWithEmail() async {
    setState(() {
      isLoading = true;
    });
    bool result = await Services().loginWithEmail(
        _emailController.text, _passwordController.text, context);
    if (result) {
      setState(() {
        isLoading = false;
        Navigator.pushReplacementNamed(context, TabsScreen.routeName);
        setSharedData();
        Messages.successMessage("Login Successful", context);
      });
    } else {
      setState(() {
        isLoading = false;
        Messages.errorMessage("Login Failed", context);
      });
    }
  }

  void _bottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: ctx,
      builder: (_) {
        return const bt.BottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return isLoading
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: theme.primary,
                ),
                const SizedBox(height: 20),
                const Text('Please wait...')
              ],
            ),
          )
        : Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 120),
                      const Text('Welcome back',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          )),
                      const SizedBox(height: 20),
                      const Text(
                        'You can chat wtih your consultant, find and book your appointment for psychotherapy.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff677294),
                        ),
                      ),
                      const SizedBox(height: 70),
                      TextFormField(
                        controller: _emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff677294)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color:
                                    const Color(0xff677294).withOpacity(0.16)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color:
                                    const Color(0xff677294).withOpacity(0.16)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Email should not be empty and email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _emailController.text = value.toString();
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: !_obscureText
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: const Icon(Icons.visibility_rounded))
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: const Icon(Icons.visibility_off)),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff677294)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color:
                                    const Color(0xff677294).withOpacity(0.16)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color:
                                    const Color(0xff677294).withOpacity(0.16)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            if (value.length <= 6) {
                              return 'Password should be at least 6 characters!';
                            }
                            return 'Password should not be Empty!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _passwordController.text = value.toString();
                        },
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.bottomRight,
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0),
                          onPressed: () => _bottomSheet(context),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _loginWithEmail();
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "OR",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                            onTap: () => _loginWithGoogle(),
                            child:
                                GoogleFacebookCard(name: "Login with Google")),
                      ),
                      const SizedBox(height: 35),
                    ]),
              ),
            ),
          );
  }
}
