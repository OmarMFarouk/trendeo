import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import 'package:trendeo/components/custom_positioned.dart';
import 'package:trendeo/components/link_button.dart';
import 'package:trendeo/core/navigator_app.dart';

import 'package:trendeo/themes/theme_button.dart';
import 'package:trendeo/themes/theme_description.dart';
import 'package:trendeo/themes/theme_titel.dart';
import 'package:trendeo/themes/thene_text.dart';
import 'package:trendeo/widgets/inpout_text.dart';

import '../bloc/auth_bloc/auth_cubit.dart';
import '../bloc/auth_bloc/auth_states.dart';
import '../src/trendeo_app.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;
  late SMITrigger confetti;

  void _onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void singIn(BuildContext context) {
    // confetti.fire();
    setState(() {
      isShowConfetti = true;
      isShowLoading = true;
    });
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (_formKey.currentState!.validate()) {
          success.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                isShowLoading = false;
              });
              confetti.fire();
              // Navigate & hide confetti
              Future.delayed(const Duration(seconds: 1), () {
                // Navigator.pop(context);
                navigatorApp(context, const TrendeoApp());
              });
            },
          );
        } else {
          error.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                isShowLoading = false;
              });
              reset.fire();
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      state is AuthSuccess ? singIn(context) : null;
    }, builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // email titel
                const ThemeText(text: "Email"),

                // inpout user email
                InpoutText(
                  controller: cubit.email,
                  erorrText: "E-mail is required",
                  svgIcon: "assets/icons/email.svg",
                  textInputType: TextInputType.emailAddress,
                ),

                // Passwerd titel
                const ThemeText(text: "Password"),

                // inpout user passwerd
                InpoutText(
                  controller: cubit.password,
                  erorrText: "Password is required",
                  svgIcon: "assets/icons/password.svg",
                  textInputType: TextInputType.visiblePassword,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: ThemeButton(
                    icon: CupertinoIcons.arrow_right,
                    text: "Sign In",
                    onPressed: () {
                      cubit.loginUser(context);
                      singIn(context);
                    },
                  ),
                ),

                // Divider or connect with
                Row(
                  children: [
                    const Expanded(flex: 2, child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.sp),
                      child: const ThemeTitel(text: "OR", size: 15),
                    ),
                    const Expanded(flex: 2, child: Divider()),
                  ],
                ),

                // Description sign up with accunts
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ThemeDescription(
                    text: "Sign up with Email, Apple or Google",
                    size: 15,
                    textAlign: TextAlign.center,
                  ),
                ),

                // Link using other accounts
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Link with gmail
                    LinkButton(
                      svgIcon: "assets/icons/email_box.svg",
                      onPressed: () {},
                    ),

                    // Link with google
                    LinkButton(
                      svgIcon: "assets/icons/google_box.svg",
                      onPressed: () {},
                    ),

                    // Link with apple
                    LinkButton(
                      svgIcon: "assets/icons/apple_box.svg",
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
          isShowLoading
              ? CustomPositioned(
                  child: RiveAnimation.asset(
                    'assets/RiveAssets/check.riv',
                    fit: BoxFit.cover,
                    onInit: _onCheckRiveInit,
                  ),
                )
              : const SizedBox(),
          isShowConfetti
              ? CustomPositioned(
                  scale: 6,
                  child: RiveAnimation.asset(
                    "assets/RiveAssets/confetti.riv",
                    onInit: _onConfettiRiveInit,
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox(),
        ],
      );
    });
  }
}
