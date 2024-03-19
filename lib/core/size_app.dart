import 'package:flutter/widgets.dart';

class SizeApp {
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;



  /// [screenWidth] Save the screen width value
  /// [screenHeight] Save the screen height value
  /// [orientation] Screen state reference
  /// [defaultSize] Save  The Screen state reference

  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;

    defaultSize = orientation == Orientation.landscape

        // if Orientation lands cape return widith = screenWidth
        // if Orientation portrait return widith = screenHight

        ? screenHeight! * .024
        : screenWidth! * .024;

    //  Testing The defaultSize  (Size Screen Px)
  }
}
