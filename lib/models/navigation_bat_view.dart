import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:trendeo/models/menu_items.dart';
import 'package:trendeo/widgets/animation_bar.dart';

class NavigationBatView extends StatelessWidget {
  const NavigationBatView(
      {super.key,
      required this.navBar,
      required this.press,
      required this.riveOnInit,
      required this.selectedNav});

  final MenuItems navBar;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final MenuItems selectedNav;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: selectedNav == navBar),
          SizedBox(
            height: 36,
            width: 36,
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