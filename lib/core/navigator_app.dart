import 'package:flutter/material.dart';

void navigatorApp(BuildContext context, Widget toScreen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => toScreen,
    ),
  );
}
