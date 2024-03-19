import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import 'package:trendeo/core/size_app.dart';

class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 200.h,
          left: 100.w,
          width: SizeApp.screenWidth! * 1.7,
          child: Image.asset("assets/images/Background.png"),
        ),
        const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
        Positioned(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: const SizedBox(),
          ),
        ),
      ],
    );
  }
}
