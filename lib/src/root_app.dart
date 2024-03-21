import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendeo/core/size_app.dart';
import 'package:trendeo/core/theme_app.dart';
import 'package:trendeo/screens/login_screen.dart';
import 'package:trendeo/src/trendeo_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/animation_bloc/animation_cubit.dart';
import '../bloc/auth_bloc/auth_cubit.dart';
import '../bloc/social_bloc/social_cubit.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeApp().init(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(create: (context) => SocialCubit()),
          BlocProvider(
            create: (context) => AnimationCubit(),
          )
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          // Use builder only if you need to use library outside ScreenUtilInit context
          builder: (_, child) {
            return MaterialApp(
              title: 'Trendeo',
              // This is the theme of your application.
              theme: lightTheme,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              home: child,
            );
          },
          // child: const OnbordingScreen(),
          // child: const HomeScreen(),
          child: FirebaseAuth.instance.currentUser != null
              ? TrendeoApp()
              : LoginScreen(),
        ));
  }
}
