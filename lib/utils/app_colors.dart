import 'package:flutter/material.dart';

import 'helpers.dart';

class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 0, 130, 200);
  static const Color secondaryColor = Color.fromARGB(255, 3, 174, 189);
  static const Color tertiaryColor = Color.fromARGB(255, 2, 146, 199);
  static const Color successColor = Color(0xFF48E98A);
  static const Color alertColor = Color(0xFFFE4651);
  static const Color darkColor = Color(0xFF292B49);
  static const Color bodyTextColor = Color(0xFF888AA0);
  static const Color lineShapeColor = Color(0xFFEBEDF9);
  static const Color shadeColor1 = Color(0xFFF4F5FA);
  static const Color shadeColor2 = Color(0xFFF7F7FB);
  static const Color bg = Color(0xfff7f7fb);

  /// Custom MaterialColor from Helper function
  static final MaterialColor primaryMaterialColor =
      Helper.generateMaterialColor(AppColors.primaryColor);
}
