import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/fontFamily_app.dart';

class ThemeText extends StatelessWidget {
  const ThemeText({
    super.key,
    this.size = 20,
    required this.text,
  });
  final double? size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color:
            ColorApp.moodApp ? ColorApp.darkTextColor : ColorApp.lightTextColor,
        fontFamily: FontApp.light,
        fontSize: size!.sp,
      ),
    );
  }
}
