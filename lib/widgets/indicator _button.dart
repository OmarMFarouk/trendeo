import 'package:flutter/cupertino.dart';
import 'package:trendeo/widgets/dot_indicator.dart';
import 'package:trendeo/models/onbording_items.dart';
import 'package:trendeo/themes/theme_icon.dart';

class IndicatorBar extends StatelessWidget {
  const IndicatorBar({
    super.key,
    required this.onPressed,
    required this.pageIndex,
  });
  final VoidCallback onPressed;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(
          onbordingItems.items.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: DotIndicator(isActive: index == pageIndex),
          ),
        ),
        const Spacer(),
        ThemeIcon(iconData: CupertinoIcons.arrow_right, onPressed: onPressed),
      ],
    );
  }
}
