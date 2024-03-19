import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/models/menu_items.dart';

class MenuViow extends StatelessWidget {
  const MenuViow(
      {super.key,
      required this.menu,
      required this.onPressed,
      required this.riveOnInit,
      required this.selectedMenu});

  final MenuItems menu;
  final VoidCallback onPressed;
  final ValueChanged<Artboard> riveOnInit;
  final MenuItems selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(color: Colors.white24, height: 1),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              width: selectedMenu == menu ? 288 : 0,
              height: 56,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorApp.moodApp
                      ? ColorApp.darkDelicateColor
                      : ColorApp.lightDelicateColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            ListTile(
              onTap: onPressed,
              leading: SizedBox(
                height: 36,
                width: 36,
                child: RiveAnimation.asset(
                  menu.rive.src,
                  artboard: menu.rive.artboard,
                  onInit: riveOnInit,
                ),
              ),
              title: Text(
                menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
