import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendeo/bloc/auth_bloc/auth_cubit.dart';
import 'package:trendeo/bloc/social_bloc/social_cubit.dart';
import 'package:trendeo/bloc/social_bloc/social_states.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/navigator_app.dart';
import 'package:trendeo/models/info_setteing_card.dart';
import 'package:trendeo/screens/login_screen.dart';
import 'package:trendeo/src/root_app.dart';
import 'package:trendeo/themes/theme_description.dart';
import 'package:trendeo/themes/theme_titel.dart';

class SetteingScreen extends StatefulWidget {
  const SetteingScreen({super.key});

  @override
  State<SetteingScreen> createState() => _SetteingScreenState();
}

class _SetteingScreenState extends State<SetteingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.moodApp
          ? ColorApp.darkBackgroundColor
          : ColorApp.lightBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.all(20),
                child: ThemeTitel(
                  text: "Trendeo Setteing",
                  size: 30,
                ),
              ),

              // mood app
              InfoSetteingCard(
                onPressed: () {
                  setState(() {
                    ColorApp.moodApp = !ColorApp.moodApp;
                  });
                  navigatorApp(context, RootApp());
                },
                iconData: ColorApp.moodApp ? Icons.mood_bad : Icons.sunny,
                text: "Mood App is ${ColorApp.moodApp ? "dark" : "light"}",
              ),

              // log Out
              BlocProvider<AuthCubit>(
                create: (context) => AuthCubit(),
                child: InfoSetteingCard(
                  onPressed: () {
                    AuthCubit.get(context).logoutUser(context);
                    navigatorApp(
                      context,
                      LoginScreen(),
                    );
                  },
                  iconData: Icons.logout_outlined,
                  text: "LogOut",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
