import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/core/navigator_app.dart';
import 'package:trendeo/widgets/indicator%20_button.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/models/onbording_items.dart';
import 'package:trendeo/models/onbording_viow.dart';
import 'package:trendeo/screens/login_screen.dart';
import 'package:trendeo/themes/theme_animated.dart';
import 'package:trendeo/themes/theme_button.dart';
import 'package:trendeo/themes/theme_description.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  bool isEnd = false;
  final pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.moodApp
          ? ColorApp.darkBackgroundColor
          : ColorApp.lightBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Onbording viow
          PageView.builder(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                isEnd = controller.items.length - 1 == value;
                pageIndex = value;
              });
            },
            itemCount: onbordingItems.items.length,
            itemBuilder: (context, index) {
              return OnbordingViow(
                onbordingItems: onbordingItems,
                index: index,
              );
            },
          ),
          // Skip Button
          Positioned(
            top: 40.h,
            right: 40.w,
            child: ThemeAnimated(
              crossFadeState:
                  isEnd ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              secondChild: TextButton(
                onPressed: () {
                  // print("Skip");
                  pageController.jumpToPage(controller.items.length - 1);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ThemeDescription(text: "Skip", size: 20),
                ),
              ),
            ),
          ),

          // Get started Button
          Positioned(
            bottom: 40.h,
            left: 40.w,
            right: 40.w,
            child: ThemeAnimated(
              crossFadeState:
                  isEnd ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              firstChild: IndicatorBar(
                pageIndex: pageIndex,
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
              ),
              secondChild: ThemeButton(
                text: "Get started",
                icon: CupertinoIcons.arrow_right,
                onPressed: () => navigatorApp(context, const LoginScreen()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
