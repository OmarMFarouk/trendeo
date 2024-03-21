import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:trendeo/bloc/auth_bloc/auth_cubit.dart';
import 'package:trendeo/bloc/auth_bloc/auth_states.dart';
import 'package:trendeo/components/custom_positioned.dart';
import 'package:trendeo/core/navigator_app.dart';
import 'package:trendeo/src/trendeo_app.dart';
import 'package:trendeo/themes/theme_button.dart';
import 'package:trendeo/themes/thene_text.dart';
import 'package:trendeo/widgets/inpout_text.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignUpForm> {
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

  void singUp(BuildContext context) {
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
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        state is AuthSuccess ? singUp(context) : null;
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // email titel
                  const ThemeText(text: "Full name"),

                  // inpout user name
                  InpoutText(
                    controller: cubit.name,
                    erorrText: "Name is required",
                    svgIcon: "assets/icons/User.svg",
                    textInputType: TextInputType.name,
                  ),

                  // user name titel
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
                      text: "Sign Up",
                      onPressed: () {
                        cubit.registerUser(context);
                        singUp(context);
                      },
                    ),
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
      },
    );
  }
}
