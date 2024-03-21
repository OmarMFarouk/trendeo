import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/size_app.dart';
import 'package:trendeo/themes/theme_description.dart';
import 'package:trendeo/themes/theme_icon.dart';
import 'package:trendeo/themes/theme_titel.dart';

bool isShowDialog = false;

Future<Object?> registrationBanner(
    BuildContext context, String titel, String welcomeText, Widget formScreen,
    {required ValueChanged onClossd}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: titel,
    context: context,
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Container(
          height: 620.h,
          margin: EdgeInsets.symmetric(horizontal: 16.sp),
          padding: EdgeInsets.symmetric(
            vertical: 32.sp,
            horizontal: 24.sp,
          ),
          decoration: BoxDecoration(
            color: ColorApp.moodApp
                ? ColorApp.darkBackgroundColor
                : ColorApp.lightBackgroundColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: AnimatedPositioned(
            top: isShowDialog ? -50 : 0,
            duration: const Duration(milliseconds: 200),
            height: SizeApp.screenHeight! * 1,
            width: SizeApp.screenWidth! * 1,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Bat
                          ThemeTitel(text: titel, size: 40.sp),

                          // Welcome Text
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.sp),
                            child: ThemeDescription(
                              text: welcomeText,
                            ),
                          ),

                          formScreen,
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -40,
                        child: ThemeIcon(
                          iconData: CupertinoIcons.clear,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  ).then(onClossd);
}
