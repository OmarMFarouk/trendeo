import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:trendeo/bloc/animation_bloc/animation_states.dart';

import '../../models/menu_items.dart';
import '../../models/navegetor_items.dart';

class AnimationCubit extends Cubit<AnimationStates> {
  AnimationCubit() : super(AnimationInitial());
  bool? isLogging;
  static AnimationCubit get(context) => BlocProvider.of(context);
  AnimationController? animationController;
  Animation<double>? scalAnimation;
  Animation<double>? animation;
  bool isSideBarOpen = false;

  NavegetorItems selectedBottonNav = bottomNavItems.first;
  MenuItems selectedSideMenu = sidebarMenus.first;

  SMIBool? isMenuOpenInput;
}
