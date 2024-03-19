import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/fontFamily_app.dart';

class ThemeDescription extends StatelessWidget {
  const ThemeDescription({
    super.key,
    required this.text,
    this.size = 18,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final int? size;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: FontApp.light,
        fontSize: size!.sp,
        color: ColorApp.moodApp
            ? ColorApp.darkDescriptionColor
            : ColorApp.lightDescriptionColor,
      ),
    );
  }
}
