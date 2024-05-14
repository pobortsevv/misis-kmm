import 'package:flutter/cupertino.dart';
import 'package:misis/figma/styles.dart';
    
class ProfileHeaderWidget extends StatelessWidget {
  final String profileName;
  final String profileStatus;
  final String filialName;

  const ProfileHeaderWidget({
    super.key,
    required this.profileName,
    required this.profileStatus,
    required this.filialName
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            profileName,
            style: const FigmaTextStyles().headline,
            maxLines: 2,
            textScaler: const TextScaler.linear(0.95),
            textAlign: TextAlign.center
          ),
          const SizedBox(height: 8),
          Text(
            profileStatus,
            style: const FigmaTextStyles().caption,
            textAlign: TextAlign.center
          ),
          const SizedBox(height: 8),
          Text(
            filialName,
            style: const FigmaTextStyles().caption,
            textAlign: TextAlign.center
          )
        ]
      ),
    );
  }
}