import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/fontFamily_app.dart';

class ThemeTitel extends StatelessWidget {
  const ThemeTitel({
    super.key,
    required this.text,
    required this.size,
    this.height,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double size;
  final double? height;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        height: height,
        fontFamily: FontApp.bold,
        fontSize: size.sp,
        color: ColorApp.moodApp
            ? ColorApp.darkAuxiliaryColor
            : ColorApp.lightAuxiliaryColor,
      ),
    );
  }
}
