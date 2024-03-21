import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendeo/bloc/social_bloc/social_cubit.dart';
import 'package:trendeo/bloc/social_bloc/social_states.dart';
import 'package:trendeo/core/color_app.dart';
import 'package:trendeo/core/navigator_app.dart';
import 'package:trendeo/models/menu_items.dart';
import 'package:trendeo/models/menu_viow.dart';
import 'package:trendeo/src/trendeo_app.dart';
import 'package:trendeo/utils/rive_utils.dart';
import 'package:trendeo/widgets/menu_hader.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  MenuItems selectedSideMenu = sidebarMenus.first;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 288.w,
        height: double.infinity,
        decoration: BoxDecoration(
          color: ColorApp.moodApp
              ? ColorApp.darkPrimaryColor
              : ColorApp.lightPrimaryColor,
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<SocialCubit, SocialStates>(
                listener: (context, state) {},
                builder: (context, state) => StreamBuilder(
                    stream: SocialCubit.get(context).userData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        DocumentSnapshot data =
                            snapshot.data as DocumentSnapshot;

                        return MenuHeder(
                          image: data['image'],
                          titel: data['name'],
                          supTitel: data['email'],
                        );
                      } else {
                        const Center(
                          child: Text('No posts to show...'),
                        );
                      }

                      return Container();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus.map(
                (menu) => MenuViow(
                  menu: menu,
                  selectedMenu: selectedSideMenu,
                  onPressed: () {
                    RiveUtils.chnageSMIBoolState(menu.rive.status!);
                    setState(() {
                      selectedSideMenu = menu;
                    });
                    Future.delayed(const Duration(milliseconds: 100), () {
                      navigatorApp(context, menu.screen!);
                    });
                  },
                  riveOnInit: (artboard) {
                    menu.rive.status = RiveUtils.getRiveInput(artboard,
                        stateMachineName: menu.rive.titel);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
                child: Text(
                  "History".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus2.map(
                (menu) => MenuViow(
                  menu: menu,
                  selectedMenu: selectedSideMenu,
                  onPressed: () {
                    RiveUtils.chnageSMIBoolState(menu.rive.status!);
                    setState(() {
                      selectedSideMenu = menu;
                    });
                    Future.delayed(const Duration(milliseconds: 100), () {
                      navigatorApp(context, menu.screen!);
                    });
                  },
                  riveOnInit: (artboard) {
                    menu.rive.status = RiveUtils.getRiveInput(artboard,
                        stateMachineName: menu.rive.titel);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
