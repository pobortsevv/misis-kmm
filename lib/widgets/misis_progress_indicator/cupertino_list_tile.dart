import 'package:flutter/cupertino.dart';
import 'package:misis/figma/styles.dart';
    
class CupertinoListItemWidget extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CupertinoListItemWidget({
    super.key, 
    required this.leading,
    required this.title,
    this.trailing = const Icon(
      CupertinoIcons.right_chevron,
      color: FigmaColors.texticonsPrimaruLight
    ),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              children: [
                leading,
                const SizedBox(width: 15),
                Expanded(child: title),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          color: FigmaColors.texticonsPrimaruLight.withOpacity(0.06),
        )
      ],
    );
  }
}