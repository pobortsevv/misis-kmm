import 'package:flutter/cupertino.dart';
import 'package:misis/figma/styles.dart';
    
class DayWidget extends StatelessWidget {
  final DayWidgetViewModel vm;
  const DayWidget({required this.vm, super.key});
  
  // TODO: Сделать адаптацию под темную тему

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async { vm.onTap(); },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 21),
        decoration: vm.isToday ? BoxDecoration(
          border: Border.all(color: FigmaColors.primary, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: vm.isSelected ? FigmaColors.primary : null
        ) : BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: vm.isSelected ? FigmaColors.primary : null
        ),
        child: Text(
          vm.shortName,
          style: vm.isSelected ? const FigmaTextStyles().darkTitle : const FigmaTextStyles().title
        ),
      )
    );
  }
}

class DayWidgetViewModel {
  final String shortName;
  final bool isToday;
  final bool isSelected;
  final Function onTap;

  DayWidgetViewModel({
    required this.shortName,
    required this.isToday,
    required this.isSelected,
    required this.onTap
  });

  DayWidgetViewModel copy({required bool isSelected}) {
    return DayWidgetViewModel(
      shortName: shortName,
      isToday: isToday,
      isSelected: isSelected,
      onTap: onTap
    );
  }
}