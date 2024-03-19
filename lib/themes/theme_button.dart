import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/fontFamily_app.dart';

class ThemeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  const ThemeButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorApp.moodApp
            ? ColorApp.darkPrimaryColor
            : ColorApp.lightPrimaryColor,
        minimumSize: const Size(double.infinity, 56),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      icon: Icon(
        icon,
        color:
            ColorApp.moodApp ? ColorApp.darkIconColor : ColorApp.lightIconColor,
      ),
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: FontApp.bold,
            fontSize: 20.sp,
            color: ColorApp.moodApp
                ? ColorApp.darkBackgroundColor
                : ColorApp.lightBackgroundColor,
          ),
        ),
      ),
    );
  }
}
