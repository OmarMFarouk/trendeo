import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import 'package:trendeo/bloc/social_bloc/social_cubit.dart';
import 'package:trendeo/bloc/social_bloc/social_states.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/size_app.dart';
import 'package:trendeo/themes/theme_button.dart';
import 'package:trendeo/themes/theme_icon.dart';
import 'package:trendeo/themes/theme_titel.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool isShowLoading = false;
  bool isShowConfetti = false;

  late SMITrigger reset;
  late SMITrigger confetti;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void appPostError(BuildContext context) {
    // confetti.fire();
    setState(() {
      isShowConfetti = true;
      isShowLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          setState(() {
            isShowLoading = false;
          });
          confetti.fire();
          // Navigate & hide confetti
          Future.delayed(const Duration(seconds: 1), () {
            // Navigator.pop(context);
          });
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          setState(() {
            isShowLoading = false;
          });
          reset.fire();
        },
      );
    }
  }

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
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: ThemeIcon(
                        iconData: Icons.arrow_back,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: ThemeTitel(
                        text: "Make a Post!",
                        size: 35,
                      ),
                    ),
                    AddTextPost(
                      controller: cubit.controller!,
                    ),
                    AddImagePost(
                      image: cubit.imageLink.toString(),
                      hasImage: cubit.hasPostImage,
                      onPressed: () {
                        cubit.imgFromGallery();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ThemeButton(
                        onPressed: () {
                          cubit.addPost();
                          Navigator.pop(context);
                        },
                        icon: Icons.addchart_outlined,
                        text: "Add to Posts",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddImagePost extends StatefulWidget {
  const AddImagePost(
      {super.key,
      required this.onPressed,
      required this.hasImage,
      required this.image});
  final VoidCallback onPressed;
  final bool hasImage;
  final String image;

  @override
  State<AddImagePost> createState() => _AddImagePostState();
}

class _AddImagePostState extends State<AddImagePost> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: SizeApp.screenWidth! * 1,
        height: SizeApp.screenHeight! / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorApp.moodApp
                ? ColorApp.darkPrimaryColor
                : ColorApp.lightPrimaryColor,
            width: 1,
          ),
        ),
        child: widget.hasImage == false
            ? IconButton(
                onPressed: widget.onPressed,
                icon: Icon(
                  Icons.add_a_photo_outlined,
                  size: 50.w,
                  color: ColorApp.moodApp
                      ? ColorApp.darkPrimaryColor
                      : ColorApp.lightPrimaryColor,
                ),
              )
            : Image.network(
                widget.image,
                fit: BoxFit.contain,
              ),
      ),
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
