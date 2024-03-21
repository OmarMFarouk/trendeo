import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendeo/bloc/social_bloc/social_cubit.dart';
import 'package:trendeo/core/navigator_app.dart';
import 'package:trendeo/screens/add_bost_screen.dart';
import 'package:trendeo/themes/theme_icon.dart';
import 'package:trendeo/components/post_card.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/size_app.dart';

import 'package:trendeo/themes/theme_titel.dart';

import '../bloc/social_bloc/social_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.moodApp
          ? ColorApp.darkBackgroundColor
          : ColorApp.lightBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(20),
              child: ThemeTitel(
                text: "Trendeo",
                size: 40,
              ),
            ),
            ListTile(
              title: const CupertinoSearchTextField(),
              leading: ThemeIcon(
                iconData: Icons.addchart_outlined,
                onPressed: () {
                  navigatorApp(context, const AddPostScreen());
                },
              ),
            ),
            Container(
              width: SizeApp.screenWidth! * 1,
              child: BlocConsumer<SocialCubit, SocialStates>(
                listener: (context, state) {
                  SocialCubit.get(context).isFavorite;
                },
                builder: (context, state) {
                  var cubit = SocialCubit.get(context);

                  return StreamBuilder(
                      stream: cubit.postsStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Center(
                            child: Text(
                              'No posts to show...',
                              style: TextStyle(fontSize: 30),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          QuerySnapshot data = snapshot.data as QuerySnapshot;
                          return Column(
                            children: data.docs
                                .map(
                                  (value) => Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: PostCard(
                                      deletePost: () =>
                                          cubit.deletePost(value.id),
                                      authorIsUser: value['email'] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.email!
                                          ? true
                                          : false,
                                      onPressed: () {
                                        cubit.likePost(
                                          email: FirebaseAuth
                                              .instance.currentUser!.email!,
                                          doc: value.id,
                                          isFavorite: cubit.isFavorite == true
                                              ? cubit.isFavorite = false
                                              : cubit.isFavorite = true,
                                        );
                                      },
                                      isFavorite: value['likes']
                                              .toString()
                                              .contains(FirebaseAuth
                                                  .instance.currentUser!.email!)
                                          ? true
                                          : false,
                                      titlePost: value['body'],
                                      likesCount: value['likes'].length,
                                      userName: value['author'],
                                      userImage: value['author_image'],
                                      image: value['image'].toString().length <
                                              5
                                          ? const SizedBox()
                                          : Expanded(
                                              child: GestureDetector(
                                                onDoubleTap: () =>
                                                    cubit.likePost(
                                                  email: FirebaseAuth.instance
                                                      .currentUser!.email!,
                                                  doc: value.id,
                                                  isFavorite:
                                                      cubit.isFavorite == true
                                                          ? cubit.isFavorite =
                                                              false
                                                          : cubit.isFavorite =
                                                              true,
                                                ),
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
                                )
                                .toList(),
                          );
                        } else
                          return SizedBox(
                            child: Text('No Data'),
                          );
                      });
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
