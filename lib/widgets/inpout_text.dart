import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trendeo/core/color_app.dart';

class InpoutText extends StatelessWidget {
  final String erorrText;
  final String svgIcon;
  final TextInputType textInputType;
  final VoidCallback? validator;
  final TextEditingController controller;
  const InpoutText({
    super.key,
    required this.erorrText,
    required this.svgIcon,
    required this.textInputType,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Container(
        // height: 60.w,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.w,
            color: ColorApp.moodApp
                ? ColorApp.darkPrimaryColor
                : ColorApp.lightPrimaryColor,
          ),
        ),
        child: Center(
          child: TextFormField(
            controller: controller,
            validator: (value) {
              validator;
              if (value!.isEmpty) {
                return erorrText;
              }
              return null;
            },
            keyboardType: textInputType,
            textInputAction: TextInputAction.next,
            style: TextStyle(
              color: ColorApp.moodApp
                  ? ColorApp.darkTextColor
                  : ColorApp.lightTextColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(svgIcon),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
