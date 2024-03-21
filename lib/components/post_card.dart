import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/size_app.dart';
import 'package:trendeo/themes/theme_description.dart';
import 'package:trendeo/themes/theme_titel.dart';
import 'package:trendeo/widgets/favorite_button.dart';

class PostCard extends StatelessWidget {
  const PostCard(
      {super.key,
      required this.titlePost,
      required this.isFavorite,
      required this.userName,
      required this.onPressed,
      required this.userImage,
      required this.image,
      required this.authorIsUser,
      required this.deletePost,
      required this.likesCount});
  final String titlePost;
  final Widget image;
  final VoidCallback onPressed;
  final VoidCallback deletePost;
  final bool isFavorite;
  final String userName;
  final String userImage;
  final int likesCount;
  final bool authorIsUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.sp),
      width: SizeApp.screenWidth! * 1,
      height: SizeApp.screenHeight! * 0.5 + 100,
      decoration: BoxDecoration(
        color: ColorApp.moodApp
            ? ColorApp.darkBackgroundColor
            : ColorApp.lightBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: ColorApp.moodApp ? Colors.white12 : Colors.black12,
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: ThemeTitel(
                textAlign: TextAlign.start,
                text: userName,
                size: 18,
              ),
              trailing: authorIsUser
                  ? IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: deletePost,
                    )
                  : null,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(userImage),
                backgroundColor: ColorApp.moodApp
                    ? ColorApp.darkDelicateColor
                    : ColorApp.lightDelicateColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ThemeDescription(text: titlePost),
          ),
          image,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FavoriteButton(
                onPressed: onPressed,
                isFavorite: isFavorite,
                count: likesCount,
              )
            ],
          )
        ],
      ),
    );
  }
}
