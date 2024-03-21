import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/themes/theme_titel.dart';

class MenuHeder extends StatelessWidget {
  const MenuHeder(
      {super.key,
      required this.titel,
      required this.supTitel,
      required this.image});
  final String titel, supTitel, image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 35.h,
              backgroundImage: NetworkImage(image),
              backgroundColor: ColorApp.moodApp
                  ? ColorApp.darkDelicateColor
                  : ColorApp.lightDelicateColor,
            ),
            ThemeTitel(text: titel, size: 15),
            Text(
              textAlign: TextAlign.start,
              supTitel,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
    // return ListTile(
    //   contentPadding: EdgeInsets.all(30.h),
    //   title: ThemeTitel(text: titel, size: 15),
    //   subtitle: Text(
    //     textAlign: TextAlign.start,
    //     supTitel,
    //     style: Theme.of(context)
    //         .textTheme
    //         .titleMedium!
    //         .copyWith(color: Colors.white70),
    //   ),
    //   leading: CircleAvatar(
    //     backgroundImage: NetworkImage('$image'),
    //     backgroundColor: ColorApp.moodApp
    //         ? ColorApp.darkDelicateColor
    //         : ColorApp.lightDelicateColor,
    //   ),
    // );
  }
}
