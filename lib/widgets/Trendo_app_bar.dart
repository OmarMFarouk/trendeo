import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import 'package:trendeo/core/color_app.dart';

class TrendeoAppBar extends StatelessWidget {
  const TrendeoAppBar({
    super.key,
    required this.isSideBarOpen,
    required this.onPressed,
    required this.riveOnInit,
  });

  final bool isSideBarOpen;
  final VoidCallback onPressed;
  final void Function(Artboard) riveOnInit;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      left: isSideBarOpen ? 220 : 0,
      top: 16,
      child: SafeArea(
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: ColorApp.moodApp
                  ? ColorApp.darkBackgroundColor
                  : ColorApp.lightBackgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ColorApp.moodApp ? Colors.white12 : Colors.black12,
                  offset: const Offset(0, 3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: RiveAnimation.asset(
              "assets/RiveAssets/menu_button.riv",
              onInit: riveOnInit,
            ),
          ),
        ),
      ),
    );
  }
}