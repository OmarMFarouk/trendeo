import 'package:flutter/material.dart';
import 'package:trendeo/models/menu_info.dart';
import 'package:trendeo/screens/chat_screen.dart';
import 'package:trendeo/screens/fevorites_sceen.dart';
import 'package:trendeo/screens/history_screen.dart';
import 'package:trendeo/src/trendeo_app.dart';
import 'package:trendeo/screens/notifications_screen.dart';
import 'package:trendeo/screens/search_screen.dart';

class MenuItems {
  final String title;
  final RiveModel rive;
  final Widget? screen;

  MenuItems({required this.screen, required this.title, required this.rive});
}

List<MenuItems> sidebarMenus = [
  MenuItems(
    title: "Search",
    screen: const SearchSceen(),
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "SEARCH",
        titel: "SEARCH_Interactivity"),
  ),
  MenuItems(
    screen: const FevoritesScreen(),
    title: "Favorites",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "LIKE/STAR",
        titel: "STAR_Interactivity"),
  ),
  MenuItems(
    screen: const ChatScreen(),
    title: "Chat",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "CHAT",
        titel: "CHAT_Interactivity"),
  ),
];
List<MenuItems> sidebarMenus2 = [
  MenuItems(
    screen: const HistoryScreen(),
    title: "History",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "TIMER",
        titel: "TIMER_Interactivity"),
  ),
  MenuItems(
    screen: const NotificationsScreen(),
    title: "Notifications",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "BELL",
        titel: "BELL_Interactivity"),
  ),
];
