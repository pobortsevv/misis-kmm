import 'package:flutter/material.dart';
import 'package:misis/figma/icons.dart';
import 'package:misis/figma/styles.dart';
import 'package:misis/models/domain/lesson.dart';
import 'package:misis/screens/schedule/widgets/lesson/double_title_widget.dart';
import 'package:misis/screens/schedule/widgets/lesson/left_icon_right_label_widget.dart';
    
class LessonWidget extends StatelessWidget {
  final LessonWidgetViewModel viewModel;

  const LessonWidget({super.key, required this.viewModel});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: FigmaColors.texticonsPrimaruLight.withOpacity(0.08),
          width: 1.0
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: FigmaColors.background1levelLight
      ),
      child: Column(
        children: [
          DoubleTitleWidget(
            title: viewModel.indexedLessonName,
            subtitle: viewModel.lessonType
          ),
          const SizedBox(height: 12),
          viewModel.groupTeacherName != null ? LeftIconRightLabelWidget(
            icon: viewModel.groupTeacherIcon,
            text: viewModel.groupTeacherName!
          ) : const SizedBox(),
          const SizedBox(height: 12),
          viewModel.roomName != null ? LeftIconRightLabelWidget(
            icon: FigmaIcons.location,
            text: viewModel.roomName!
          ) : const SizedBox()
        ],
      ),
    );
  }
}

class LessonWidgetViewModel {
  final LessonTime timeRange;
  final bool isCurrent;

  final String indexedLessonName;
  final String lessonType;
  final IconData groupTeacherIcon;
  final String? groupTeacherName;
  final String? roomName;

  LessonWidgetViewModel({
    required this.timeRange,
    required this.isCurrent,
    required this.indexedLessonName,
    required this.lessonType,
    required this.groupTeacherIcon,
    required this.groupTeacherName,
    required this.roomName
  }); 
}