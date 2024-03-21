import 'package:flutter/material.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/themes/theme_titel.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton(
      {super.key,
      required this.onPressed,
      required this.isFavorite,
      required this.count});

  final VoidCallback onPressed;
  final bool isFavorite;
  final int count;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorApp.moodApp
            ? ColorApp.darkBackgroundColor
            : ColorApp.lightBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
        color: ColorApp.moodApp
            ? ColorApp.darkAuxiliaryColor
            : ColorApp.lightAuxiliaryColor,
      ),
      label: ThemeTitel(text: "$count", size: 15),
    );
  }
}
