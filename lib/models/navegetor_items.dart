import 'package:trendeo/models/menu_info.dart';

class NavegetorItems {
  final String title;
  final RiveModel rive;
  final int screen;

  NavegetorItems(
      {required this.screen, required this.title, required this.rive});
}

List<NavegetorItems> bottomNavItems = [
  NavegetorItems(
    title: "Home",
    screen: 0,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "HOME",
        titel: "HOME_interactivity"),
  ),
  NavegetorItems(
    screen: 1,
    title: "Chat",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "CHAT",
        titel: "CHAT_Interactivity"),
  ),
  NavegetorItems(
    screen: 3,
    title: "Notification",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "BELL",
        titel: "BELL_Interactivity"),
  ),
  NavegetorItems(
    screen: 4,
    title: "Profile",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "USER",
        titel: "USER_Interactivity"),
  ),
];

/**
 *   NavegetorItems(
    screen: 2,
    title: "Search",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "SEARCH",
        titel: "SEARCH_Interactivity"),
  ),
 */