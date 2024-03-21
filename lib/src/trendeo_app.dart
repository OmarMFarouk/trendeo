import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendeo/bloc/social_bloc/social_cubit.dart';
import 'package:trendeo/bloc/social_bloc/social_states.dart';
import 'package:trendeo/core/fontFamily_app.dart';
import 'package:trendeo/core/size_app.dart';
import 'package:trendeo/screens/chat_screen.dart';
import 'package:trendeo/screens/home_screen.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/models/navegetor_items.dart';
import 'package:trendeo/models/side_menu.dart';
import 'dart:math';
import 'package:rive/rive.dart';
import 'package:trendeo/screens/persson_screen.dart';
import 'package:trendeo/screens/setteing_screen.dart';

import 'package:trendeo/widgets/Trendo_app_bar.dart';

class TrendeoApp extends StatefulWidget {
  const TrendeoApp({super.key});

  @override
  State<TrendeoApp> createState() => _TrendeoAppState();
}

class _TrendeoAppState extends State<TrendeoApp>
    with SingleTickerProviderStateMixin {
  bool isSideBarOpen = false;

  // MenuItems selectedSideMenu = sidebarMenus.first;

  late SMIBool isMenuOpenInput;

  List<String> listOfString = [
    "Home",
    "Chat",
    "Pers",
    "Sett",
  ];

  List<IconData> listOfIcon = [
    Icons.home_outlined,
    Icons.chat_outlined,
    Icons.person_outline,
    Icons.settings_outlined,
  ];
  void updateSelectedBtmNav(NavegetorItems menu) {
    if (scrollConttroler != menu) {
      setState(() {
        scrollConttroler = menu;
      });
    }
  }

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  NavegetorItems scrollConttroler = bottomNavItems.first;
  int currentIndex = 0;
  late PageController pageController;
  NavegetorItems selectedBottonNav = bottomNavItems.first;

  @override
  void initState() {
    pageController = PageController();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          cubit
            ..fetchUsers()
            ..fetchUserData()
            ..fetchPosts();
          return Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: false,
              backgroundColor: ColorApp.moodApp
                  ? ColorApp.darkPrimaryColor
                  : ColorApp.lightPrimaryColor,
              body: Stack(
                children: [
                  AnimatedPositioned(
                    width: 288,
                    height: MediaQuery.of(context).size.height,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    left: isSideBarOpen ? 0 : -288,
                    top: 0,
                    child: const SideBar(),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(
                        1 * animation.value - 30 * (animation.value) * pi / 180,
                      ),
                    child: Transform.translate(
                      offset: Offset(animation.value * 265, 0),
                      child: Transform.scale(
                        scale: scalAnimation.value,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(isSideBarOpen ? 24 : 0),
                          ),
                          child: PageView(
                            controller: pageController,
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            children: const <Widget>[
                              // 1 - home app screen
                              HomeScreen(),

                              // 2 - chat app screen
                              ChatScreen(),

                              // 3 - user persson screen
                              PerssonScreen(),

                              // 4 - setteing app screen
                              SetteingScreen(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  TrendeoAppBar(
                    isSideBarOpen: isSideBarOpen,
                    onPressed: () {
                      isMenuOpenInput.value = !isMenuOpenInput.value;

                      if (_animationController.value == 0) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }

                      setState(
                        () {
                          isSideBarOpen = !isSideBarOpen;
                        },
                      );
                    },
                    riveOnInit: (artboard) {
                      final controller = StateMachineController.fromArtboard(
                        artboard,
                        "State Machine",
                      );

                      artboard.addController(controller!);

                      isMenuOpenInput =
                          controller.findInput<bool>("isOpen") as SMIBool;
                      isMenuOpenInput.value = true;
                    },
                  ),
                ],
              ),
              bottomNavigationBar: isSideBarOpen
                  ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.all(10),
                      width: SizeApp.screenWidth,
                      height: 70,
                      decoration: BoxDecoration(
                        color: ColorApp.moodApp
                            ? ColorApp.darkBackgroundColor
                            : ColorApp.lightBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: ColorApp.moodApp
                                ? Colors.white12
                                : Colors.black12,
                            offset: const Offset(0, 3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeApp.screenWidth! * .02),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                            setState(
                              () {
                                currentIndex = index;
                                HapticFeedback.lightImpact();
                              },
                            );
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Stack(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? SizeApp.screenWidth! * .32
                                    : SizeApp.screenWidth! * .18,
                                alignment: Alignment.center,
                                //
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    height: index == currentIndex
                                        ? SizeApp.screenHeight! * .12
                                        : 0,
                                    width: index == currentIndex
                                        ? SizeApp.screenWidth! * .32
                                        : 0,
                                    decoration: BoxDecoration(
                                      color: index == currentIndex
                                          ? ColorApp.moodApp
                                              ? ColorApp.darkPrimaryColor
                                                  .withOpacity(.3)
                                              : ColorApp.lightPrimaryColor
                                                  .withOpacity(.3)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              //
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? SizeApp.screenWidth! * .31
                                    : SizeApp.screenWidth! * .18,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          width: index == currentIndex
                                              ? SizeApp.screenWidth! * .13
                                              : 0,
                                        ),
                                        AnimatedOpacity(
                                          opacity:
                                              index == currentIndex ? 1 : 0,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: Text(
                                            index == currentIndex
                                                ? listOfString[index]
                                                : "",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: FontApp.bold,
                                              color: ColorApp.moodApp
                                                  ? ColorApp.darkPrimaryColor
                                                  : ColorApp.lightPrimaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          width: index == currentIndex
                                              ? SizeApp.screenWidth! * .03
                                              : 28,
                                        ),
                                        Icon(
                                          listOfIcon[index],
                                          size: SizeApp.screenWidth! * .076,
                                          color: index == currentIndex
                                              ? ColorApp.moodApp
                                                  ? ColorApp.darkPrimaryColor
                                                  : ColorApp.lightPrimaryColor
                                              : ColorApp.moodApp
                                                  ? ColorApp
                                                      .darkDescriptionColor
                                                  : ColorApp
                                                      .lightDescriptionColor,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
        });
  }
}

/**
 * Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ColorApp.moodApp
                    ? ColorApp.darkPrimaryColor.withOpacity(.3)
                    : ColorApp.lightPrimaryColor.withOpacity(.3),
                borderRadius: BorderRadius.circular(30.sp),
                boxShadow: [
                  BoxShadow(
                    color: ColorApp.moodApp ? Colors.white12 : Colors.black12,
                    offset: const Offset(0, 3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    bottomNavItems.length,
                    (index) {
                      NavegetorItems navBar = bottomNavItems[index];
                      return NavigationBatView(
                        navBar: navBar,
                        onPressed: () {
                          RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                          updateSelectedBtmNav(navBar);

                          pageController.jumpToPage(index);
                        },
                        riveOnInit: (artboard) {
                          navBar.rive.status = RiveUtils.getRiveInput(
                            artboard,
                            stateMachineName: navBar.rive.titel,
                          );
                        },
                        selectedNav: selectedBottonNav,
                      );
                    },
                  ),
                ],
              ),
            ),
 */