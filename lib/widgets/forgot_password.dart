import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key, this.emailController}) : super(key: key);
  TextEditingController? emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Forgot password',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 20),
        const Text(
          'Enter your email for the verification proccesss, we will send reset password link to your email.',
          style: TextStyle(
            color: Color(0xff677294),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 35),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Color(0xff677294)),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide:
                  BorderSide(color: const Color(0xff677294).withOpacity(0.16)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide:
                  BorderSide(color: const Color(0xff677294).withOpacity(0.16)),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
      ],
    );
  }
}
