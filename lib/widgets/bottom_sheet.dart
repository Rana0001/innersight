import 'dart:math';

import 'package:flutter/material.dart';
import 'package:innersight/services/services.dart';

import './forgot_password.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  final TextEditingController _emailController = TextEditingController();
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateOnlyText = ButtonState.idle;

  void sendResetPasswordMail() async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        await Services().sendForgetMail(_emailController.text, context);
        Future.delayed(
          const Duration(seconds: 1),
          () {
            setState(
              () {
                stateTextWithIcon = Random.secure().nextBool()
                    ? ButtonState.success
                    : ButtonState.fail;
              },
            );
          },
        );

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;

        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(
      () {
        stateTextWithIcon = stateTextWithIcon;
      },
    );
    Future.delayed(
        const Duration(seconds: 4), () => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      height: 700,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 5,
            width: 130,
            decoration: BoxDecoration(
              color: const Color(0xffC4C4C4),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 50),
        ForgotPassword(emailController: _emailController),
        const SizedBox(height: 30),
        Container(
          height: 54,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ProgressButton.icon(
              iconedButtons: {
                ButtonState.idle: IconedButton(
                    text: 'Send',
                    icon: const Icon(Icons.send, color: Colors.white),
                    color: theme.primary),
                ButtonState.loading:
                    IconedButton(text: 'Loading', color: theme.primary),
                ButtonState.fail: const IconedButton(
                    text: 'Failed',
                    icon: Icon(Icons.cancel, color: Colors.white),
                    color: Color(0xffFF5B5B)),
                ButtonState.success: IconedButton(
                    text: 'Sent',
                    icon: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade400)
              },
              onPressed: () {
                if (_emailController.text != "") {
                  sendResetPasswordMail();
                }
              },
              state: stateTextWithIcon),
        ),
      ]),
    );
  }
}
