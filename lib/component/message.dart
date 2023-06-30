import 'package:flutter/material.dart';

class Messages {
  static ScaffoldFeatureController successMessage(
      String? message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(
        seconds: 2,
      ),
      dismissDirection: DismissDirection.endToStart,
      backgroundColor: Colors.green,
      closeIconColor: Colors.white,
      showCloseIcon: true,
      content: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ));
  }

  static ScaffoldFeatureController errorMessage(
      String? e, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(
        seconds: 2,
      ),
      closeIconColor: Colors.white,
      showCloseIcon: true,
      dismissDirection: DismissDirection.endToStart,
      backgroundColor: Colors.red,
      content: Text(
        e!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ));
  }
}
