import 'package:flutter/cupertino.dart';
import 'package:misis/figma/styles.dart';
    
class DoubleTitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const DoubleTitleWidget({
    super.key,
    required this.title,
    required this.subtitle
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const FigmaTextStyles().boldBody,
          maxLines: 2,
          textScaler: const TextScaler.linear(0.95),
          textAlign: TextAlign.left
        ),
        Text(
          subtitle,
          style: const FigmaTextStyles().footnote,
          textAlign: TextAlign.left
        )
      ],
    );
  }
}