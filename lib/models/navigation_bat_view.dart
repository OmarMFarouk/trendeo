import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import 'package:trendeo/models/navegetor_items.dart';
import 'package:trendeo/widgets/animation_bar.dart';

class NavigationBatView extends StatelessWidget {
  const NavigationBatView(
      {super.key,
      required this.navBar,
      required this.onPressed,
      required this.riveOnInit,
      required this.selectedNav});

  final NavegetorItems navBar;
  final VoidCallback onPressed;
  final ValueChanged<Artboard> riveOnInit;
  final NavegetorItems selectedNav;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: selectedNav == navBar),
          SizedBox(
            height: 36.h,
            width: 36.w,
            child: Opacity(
              opacity: selectedNav == navBar ? 1 : 0.5,
              child: RiveAnimation.asset(
                navBar.rive.src,
                artboard: navBar.rive.artboard,
                onInit: riveOnInit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
