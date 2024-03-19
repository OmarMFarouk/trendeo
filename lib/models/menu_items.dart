import 'package:flutter/material.dart';
import 'package:trendeo/models/menu_info.dart';
import 'package:flutter/animation.dart';

class MenuItems {
  final String title;
  final RiveModel rive;
  final VoidCallback onPressed;

  MenuItems({required this.onPressed, required this.title, required this.rive});
}

List<MenuItems> sidebarMenus = [
  MenuItems(
    title: "Home",
   onPressed: () {  },
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "HOME",
        titel: "HOME_interactivity"), 
  ),
  MenuItems(
    title: "Search",
   onPressed: () {  },
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "SEARCH",
        titel: "SEARCH_Interactivity"),
  ),
  MenuItems(
  onPressed: () {  },
    title: "Favorites",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "LIKE/STAR",
        titel: "STAR_Interactivity"),
  ),
  MenuItems(
  onPressed: () {  },
    title: "Chat",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "CHAT",
        titel: "CHAT_Interactivity"),
  ),
];
List<MenuItems> sidebarMenus2 = [
  MenuItems(
 onPressed: () {  },
    title: "History",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "TIMER",
        titel: "TIMER_Interactivity"),
  ),
  MenuItems(
onPressed: () {  },
    title: "Notifications",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "BELL",
        titel: "BELL_Interactivity"),
  ),
];
