import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/bloc/social_bloc/social_cubit.dart';
import 'package:trendeo/bloc/social_bloc/social_states.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/screens/add_bost_screen.dart';
import 'package:trendeo/themes/theme_titel.dart';

class PerssonScreen extends StatelessWidget {
  const PerssonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        state is SocialSuccessState
            ? SocialCubit.get(context).hasPostImage
            : null;
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          backgroundColor: ColorApp.moodApp
              ? ColorApp.darkBackgroundColor
              : ColorApp.lightBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: const ThemeTitel(
                      text: "User Profile",
                      size: 30,
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: AddImagePost(
                            image: cubit.profilePicture.toString(),
                            hasImage: cubit.hasProfileImage,
                            onPressed: () {},
                          ),
                        ),
                        Positioned(
                          bottom: -5,
                          right: -5,
                          child: IconButton(
                            icon: Icon(
                              Icons.image,
                              size: 35,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              cubit.imgFromGallery2();
                              cubit.changeProfilePicture();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
