import 'package:flutter/material.dart';
import 'package:innersight/component/message.dart';
import 'package:innersight/models/patient.dart';
import 'package:innersight/services/services.dart';

import '../screens/auth_screen.dart';
import './google_facebook_card.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool value = false;
  bool _obscureText = true;
  bool _obscureText2 = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool isLoading = false;
  final Services _services = Services();

  signUpWithGoogle() async {
    setState(() {
      isLoading = true;
    });
    bool result = await _services.signUpWithGoogle(context);
    if (result) {
      setState(() {
        isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthScreen()),
            (route) => false);
        Messages.successMessage("Signup! Successful", context);
      });
    } else {
      setState(() {
        isLoading = false;
        Messages.errorMessage("Signup! Failed", context);
      });
    }
  }

  signUp() async {
    setState(() {
      isLoading = true;
    });
    Patient patient = Patient();
    patient.email = _emailController.text;
    patient.firstName = _firstNameController.text;
    patient.lastName = _lastNameController.text;

    bool result =
        await _services.signUp(patient, _passwordController.text, context);

    if (result) {
      setState(() {
        isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthScreen()),
            (route) => false);
        Messages.successMessage("Signup! Successful", context);
      });
    } else {
      setState(() {
        isLoading = false;
        Messages.errorMessage("Signup! Failed", context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
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
                      const SizedBox(height: 50),
                      const Text('Join us to start psychotherapy',
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
                      const SizedBox(height: 30),
                      MaterialButton(
                          onPressed: () {
                            signUpWithGoogle();
                          },
                          child: GoogleFacebookCard(
                            name: "Signup with Google",
                          )),
                      const SizedBox(height: 20),
                      const Text(
                        'Or sign up with Email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff677294),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _firstNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'First Name',
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
                            return 'First Name should not be empty!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _firstNameController.text = value.toString();
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _lastNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
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
                            return 'Last Name should not be empty!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _lastNameController.text = value.toString();
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
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
                            return 'Email must not be empty and should contain @';
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
                        obscureText: _obscureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty || value.length <= 6) {
                            return 'Password must not be empty and should be 6 characters long!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController2,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _obscureText2,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          suffixIcon: !_obscureText2
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText2 = !_obscureText2;
                                    });
                                  },
                                  icon: const Icon(Icons.visibility_rounded))
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText2 = !_obscureText2;
                                    });
                                  },
                                  icon: const Icon(Icons.visibility_off)),
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
                          if (value!.isEmpty || value.length <= 6) {
                            return 'Confirm Password must not be empty and should be 6 characters long!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _passwordController2.text = value.toString();
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: value,
                            onChanged: (value) {
                              setState(() {
                                this.value = value!;
                              });
                            },
                          ), //C
                          const Text(
                            "I agree with the Terms of Service & Privacy Policy",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff677294),
                            ),
                          ),
                        ],
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
                          onPressed: () {
                            if (value) {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                if (_passwordController.text ==
                                    _passwordController2.text) {
                                  signUp();
                                } else {
                                  Messages.errorMessage(
                                      "Make Sure Password and Confirm Password is Same",
                                      context);
                                }
                              }
                            } else {
                              Messages.errorMessage(
                                  "Please! Agree with the Terms of Service & Privacy Policy",
                                  context);
                            }
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ]),
              ),
            ),
          );
  }
}
