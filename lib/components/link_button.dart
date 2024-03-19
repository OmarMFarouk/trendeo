import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    super.key,
    required this.svgIcon,
    required this.onPressed,
  });
  final String svgIcon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        svgIcon,
        width: 50.w,
      ),
    );
  }
}