import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import 'package:trendeo/components/sign_in_form.dart';
import 'package:trendeo/components/sign_up_form.dart';
import 'package:trendeo/components/registration_banner.dart';
import 'package:trendeo/widgets/background_filter.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/image_app.dart';
import 'package:trendeo/themes/theme_animated_button.dart';
import 'package:trendeo/themes/theme_description.dart';
import 'package:trendeo/themes/theme_titel.dart';
import 'package:trendeo/themes/thene_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late RiveAnimationController btnAnimationController;
  @override
  void initState() {
    btnAnimationController = OneShotAnimation("active", autoplay: false);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.moodApp
          ? ColorApp.darkBackgroundColor
          : ColorApp.lightBackgroundColor,
      body: Stack(
        children: [
          const BackgroundFilter(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 260.w,
                    child: Column(
                      children: [
                        Image.asset(imageApp.logoApp),
                        const ThemeTitel(
                          textAlign: TextAlign.start,
                          height: 1.2,
                          text: "Trendeo",
                          size: 50,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const ThemeText(
                          text:
                              " Lorem ipsum dolor sit amet consectetur, adipisicing elit. Expedita eius reprehenderit",
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ThemeAnimatedButton(
                    text: "Start login",
                    icon: CupertinoIcons.arrow_right,
                    btnAnimationController: btnAnimationController,
                    onTap: () {
                      btnAnimationController.isActive = true;
                      Future.delayed(const Duration(milliseconds: 800), () {
                        registrationBanner(
                          context, // Build context build for screen
                          "Sign In", // Titel screen
                          "Welcome dear, don't miss the fun", // Description screen

                          const SignInForm(),
                          onClossd: (value) {
                            isShowDialog = false;
                          },
                        );
                        setState(() {
                          isShowDialog = true;
                        });
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  const ThemeDescription(
                    textAlign: TextAlign.start,
                    text:
                        "You don't have an account\n...it's not a problem, just",
                  ),
                  TextButton(
                    onPressed: () {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        registrationBanner(
                          context, // Build context build for screen
                          "Sign up", // Titel screen
                          "Hello dear you've been missed", // Description screen
                          const SignUpForm(),
                          onClossd: (value) {
                            isShowDialog = false;
                          },
                        );
                      });
                      setState(() {
                        isShowDialog = true;
                      });
                    },
                    child: Text(
                      "create an account",
                      style: TextStyle(
                        fontSize: 17,
                        color: ColorApp.moodApp
                            ? ColorApp.darkPrimaryColor
                            : ColorApp.darkPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
