import 'package:flutter/material.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/themes/theme_titel.dart';

class ChatCardViow extends StatelessWidget {
  const ChatCardViow({
    super.key,
    required this.titel,
    required this.image,
    required this.onTap,
  });
  final String titel;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: ThemeTitel(
        text: titel,
        size: 15,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image),
        backgroundColor: ColorApp.moodApp
            ? ColorApp.darkPrimaryColor
            : ColorApp.lightPrimaryColor,
      ),
    );
  }
}
