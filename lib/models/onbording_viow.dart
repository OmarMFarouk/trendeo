import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/models/onbording_items.dart';
import 'package:trendeo/themes/theme_description.dart';
import 'package:trendeo/themes/theme_titel.dart';

class OnbordingViow extends StatelessWidget {
  const OnbordingViow({
    super.key,
    required this.onbordingItems,
    required this.index,
  });

  final OnbordingItems onbordingItems;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(onbordingItems.items[index].image),
        ThemeTitel(text: onbordingItems.items[index].titel, size: 22),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child:
              ThemeDescription(text: onbordingItems.items[index].description),
        ),
      ],
    );
  }
}
