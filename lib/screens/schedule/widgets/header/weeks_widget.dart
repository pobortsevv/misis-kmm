import 'package:flutter/material.dart';
import 'package:misis/figma/styles.dart';
import 'package:misis/screens/schedule/widgets/header/day_widget.dart';
import 'package:misis/screens/schedule/widgets/header/days_row.dart';
    
class WeeksWidget extends StatelessWidget {
  final List<DayWidgetViewModel> upperWeek;
  final List<DayWidgetViewModel> bottomWeek;

  const WeeksWidget({
    required this.upperWeek,
    required this.bottomWeek,
    super.key
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: FigmaColors.background1levelLight
      ),
      child: Column(
        children: [
          DaysRow(days: upperWeek),
          const SizedBox(height: 12),
          DaysRow(days: bottomWeek)
        ],
      ),
    );
  }
}