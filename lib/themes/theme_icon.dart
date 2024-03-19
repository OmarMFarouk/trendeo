import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/core/color_app.dart';

class ThemeIcon extends StatelessWidget {
  const ThemeIcon({
    super.key,
    required this.iconData,
    required this.onPressed,
  });
  final IconData iconData;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22.w,
      backgroundColor: ColorApp.moodApp
          ? ColorApp.darkPrimaryColor
          : ColorApp.lightPrimaryColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          size: 20.w,
          color: ColorApp.moodApp
              ? ColorApp.darkIconColor
              : ColorApp.lightIconColor,
        ),
      ),
    );
  }
}
