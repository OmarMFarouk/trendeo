import 'package:flutter/material.dart';

void navigatorApp(BuildContext context, Widget toScreen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => toScreen,
    ),
  );
}

void navigatorReplaceApp(BuildContext context, Widget toScreen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => toScreen,
    ),
  );
}
