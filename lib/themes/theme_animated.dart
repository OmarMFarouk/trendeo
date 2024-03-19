import 'package:flutter/material.dart';

class ThemeAnimated extends StatelessWidget {
  final CrossFadeState crossFadeState;
  final Widget secondChild;
  final Widget? firstChild;
  const ThemeAnimated({
    super.key,
    required this.crossFadeState,
    required this.secondChild,
    this.firstChild = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: firstChild!,
      secondChild: secondChild,
      crossFadeState: crossFadeState,
      duration: const Duration(milliseconds: 600),
    );
  }
}
