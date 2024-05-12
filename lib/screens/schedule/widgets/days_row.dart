import 'package:flutter/cupertino.dart';
import 'package:misis/screens/schedule/widgets/day_widget.dart';
    
class DaysRow extends StatelessWidget {
  final List<DayWidgetViewModel> days;

  const DaysRow({required this.days, super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: days.map((model) => DayWidget(vm: model)).toList(),
    ); 
  }
}