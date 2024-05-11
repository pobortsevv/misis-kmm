import 'package:flutter/material.dart';
import 'package:misis/screens/schedule/widgets/day_widget.dart';
import 'package:misis/screens/schedule/widgets/days_row.dart';
    
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
    return Column(
      children: [
        DaysRow(days: upperWeek),
        DaysRow(days: bottomWeek)
      ],
    ); 
  }
}