import 'package:flutter/cupertino.dart';
import 'package:misis/figma/styles.dart';
    
class CupertinoListItemWidget extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CupertinoListItemWidget({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing = const Icon(
      CupertinoIcons.right_chevron,
      color: FigmaColors.texticonsPrimaruLight
    ),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              children: [
                if (leading != null) leading!,
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      if (subtitle != null) 
                       Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: subtitle!
                        )
                    ],
                  )
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          Container(
            height: 1,
            color: FigmaColors.texticonsPrimaruLight.withOpacity(0.06),
          )
        ],
      ),
    );
  }
}