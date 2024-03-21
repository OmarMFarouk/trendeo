import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:trendeo/bloc/social_bloc/social_cubit.dart';
import 'package:trendeo/bloc/social_bloc/social_states.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/size_app.dart';
import 'package:trendeo/themes/theme_button.dart';
import 'package:trendeo/themes/theme_icon.dart';
import 'package:trendeo/themes/theme_titel.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen(
      {super.key,
      required this.receiverEmail,
      required this.receiverId,
      required this.receiverName,
      required this.receiverStatus});
  String receiverEmail;
  String receiverId;
  String receiverName;
  bool? receiverStatus;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  void scrollDown() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          backgroundColor: ColorApp.moodApp
              ? ColorApp.darkBackgroundColor
              : ColorApp.lightBackgroundColor,
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Row(
                      children: [
                        ThemeIcon(
                          iconData: Icons.arrow_back,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ThemeTitel(
                            text: receiverName,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 15.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              color: receiverStatus == true
                                  ? Colors.green
                                  : Colors.grey,
                              shape: BoxShape.circle),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: cubit.getMessages(
                        FirebaseAuth.instance.currentUser!.uid, receiverId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      QuerySnapshot messages = snapshot.data as QuerySnapshot;

                      return Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          reverse: true,
                          controller: scrollController,
                          children: messages.docs
                              .map((e) => Align(
                                    alignment: e['senderEmail'] ==
                                            FirebaseAuth
                                                .instance.currentUser!.email
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: e['senderEmail'] ==
                                                  FirebaseAuth.instance
                                                      .currentUser!.email
                                              ? BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                  ),
                                                  color: Colors.red[700])
                                              : BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20),
                                                  ),
                                                  color: Colors.grey[500]),
                                          child: Column(
                                            children: [
                                              Text(
                                                e['text'],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              // Text(messages.docs[index]['time'].toString())
                                            ],
                                          )),
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
                  AddTextPost(
                    controller: cubit.msgController!,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ThemeButton(
                      onPressed: () {
                        cubit.sendMessage(receiverId);
                        scrollDown();
                        FocusScope.of(context).unfocus();
                      },
                      icon: Icons.addchart_outlined,
                      text: "Send",
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

class AddTextPost extends StatelessWidget {
  final TextEditingController controller;
  const AddTextPost({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60.w,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),

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
          maxLines: null,
          validator: (value) {
            if (value!.isEmpty) {
              return "what are you thinking about !";
            }
            return null;
          },
          keyboardType: TextInputType.multiline,
          controller: controller,
          textInputAction: TextInputAction.done,
          style: TextStyle(
            color: ColorApp.moodApp
                ? ColorApp.darkTextColor
                : ColorApp.lightTextColor,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.addchart_outlined),
            ),
          ),
        ),
      ),
    );
  }
}
