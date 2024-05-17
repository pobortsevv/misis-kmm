import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:misis/figma/styles.dart';
import 'package:misis/screens/schedule/widgets/header/day_widget.dart';
import 'package:misis/screens/schedule/widgets/header/weeks_widget.dart';
import 'package:misis/screens/schedule/widgets/lesson/lesson_widget.dart';
    
class LoadedScheduleWidget extends StatelessWidget {
  final List<DayWidgetViewModel> upperWeekViewModels;
  final List<DayWidgetViewModel> bottomWeekViewModels;
  final List<LessonWidgetViewModel> lessons;

  const LoadedScheduleWidget({
    super.key,
    required this.upperWeekViewModels,
    required this.bottomWeekViewModels,
    required this.lessons
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: FigmaColors.backgroundAccentLight,
      child:
        Column(children: [
          WeeksWidget(
            upperWeek: upperWeekViewModels, 
            bottomWeek: bottomWeekViewModels
          ),
          Expanded(
            child: lessons.isNotEmpty ? ListView.builder(
              padding: const EdgeInsets.only(top: 26),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final model = lessons[index];
                return LessonWidget(viewModel: model);
              },
            ) : Center(
                child: Text("Сегодня пар нет", style: const FigmaTextStyles().secondaryBody)
              )
          )
        ]
      )
    );
  }
}