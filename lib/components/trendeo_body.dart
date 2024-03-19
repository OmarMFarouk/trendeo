import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/bloc/social_bloc/social_cubit.dart';
import 'package:trendeo/bloc/social_bloc/social_states.dart';
import 'package:trendeo/components/post_card.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/size_app.dart';

import 'package:trendeo/themes/theme_titel.dart';

class TrendeoBody extends StatefulWidget {
  const TrendeoBody({super.key});

  @override
  State<TrendeoBody> createState() => _TrendeoBodyState();
}

class _TrendeoBodyState extends State<TrendeoBody> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.moodApp
          ? ColorApp.darkBackgroundColor
          : ColorApp.lightBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.all(20),
                child: ThemeTitel(
                  text: "Trendeo",
                  size: 40,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: SizeApp.screenWidth! * 1,
                  child: BlocConsumer<SocialCubit, SocialStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      var cubit = SocialCubit.get(context);
                      return StreamBuilder(
                        stream: cubit.postsStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            QuerySnapshot data = snapshot.data as QuerySnapshot;

                            return Column(
                              children: data.docs
                                  .map(
                                    (value) => Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: PostCard(
                                        onPressed: () {
                                          setState(() {
                                            cubit.likeChecker(
                                                isFavorite: isFavorite,
                                                cubit: cubit);
                                          });
                                        },
                                        isFavorite: value['likes']
                                                .toString()
                                                .contains(FirebaseAuth.instance
                                                    .currentUser!.email!)
                                            ? isFavorite = true
                                            : isFavorite = false,
                                        titlePost: value['body'],
                                        likesCount: value['likes'].length,
                                        userName: value['author'],
                                        userImage: value['author_image'],
                                        image: value['image'] == ""
                                            ? const SizedBox()
                                            : Expanded(
                                                child: GestureDetector(
                                                  onDoubleTap: () =>
                                                      setState(() {
                                                    cubit.likeChecker(
                                                        isFavorite: isFavorite,
                                                        cubit: cubit);
                                                  }),
                                                  child: SizedBox(
                                                    width: SizeApp.screenWidth,
                                                    height: 200.h,
                                                    child: Image.network(
                                                      value['image'],
                                                      fit: BoxFit.fitHeight,
                                                      alignment:
                                                          Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          } else {
                            const Center(
                              child: Text('No posts to show...'),
                            );
                          }

                          return Container();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
