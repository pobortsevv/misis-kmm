import 'package:flutter/cupertino.dart';
import 'package:misis/figma/icons.dart';
import 'package:misis/figma/styles.dart';
import 'package:misis/models/domain/schedule.dart';
    
class TimeRangeWidget extends StatelessWidget {
  final LessonTime timeRange;
  final bool isCurrent;

  const TimeRangeWidget({
    super.key,
    required this.timeRange,
    required this.isCurrent
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(child: Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 24),
          child: Icon(
            FigmaIcons.mark,
            size: 12,
            color: isCurrent ? const Color(0xfffebf48) : FigmaColors.texticonsPrimaruLight.withOpacity(0.3))
        ),
        Text(timeRange.start, style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
        Text(" - ", style: const FigmaTextStyles().secondaryTitle),
        Text(timeRange.end, style: const FigmaTextStyles().secondaryTitle)
      ],
    ));
  }
}