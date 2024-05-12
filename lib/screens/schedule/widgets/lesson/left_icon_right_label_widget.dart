import 'package:flutter/cupertino.dart';
import 'package:misis/figma/styles.dart';
    
class LeftIconRightLabelWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const LeftIconRightLabelWidget({
    super.key,
    required this.icon,
    required this.text
  });
  
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 6),
          child: Icon(icon),
        ),
        Text(text, style: const FigmaTextStyles().body)
      ]
    );
  }
}