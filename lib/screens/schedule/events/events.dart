import 'package:misis/models/domain/schedule.dart';
import 'package:misis/mvvm/observer.dart';
import 'package:misis/screens/schedule/widgets/day_widget.dart';

enum LoadingState {
  isLoading,
  dataLoaded,
  loadingError
}

class LoadingEvent extends ViewEvent {
  LoadingEvent() : super("LoadingEvent");
}

class DataLoadedEvent extends ViewEvent {
  final ScheduleDataSource dataSource;

  DataLoadedEvent({required this.dataSource}) : super("DataLoadedEvent");
}

class DataSourceUpdatingEvent extends ViewEvent {
  final ScheduleDataSource dataSource;

  DataSourceUpdatingEvent({required this.dataSource})
  : super("DataSourceUpdatingEvent");
}

class LoadingErrorEvent extends ViewEvent {
  String error;

  LoadingErrorEvent({required this.error}) : super("LoadingErrorEvent");
}

class ScheduleDataSource {
  final List<DayWidgetViewModel> upperWeekViewModels;
  final List<DayWidgetViewModel> bottomWeekViewModels;
  final List<Lesson> lessons;

  ScheduleDataSource({
    required this.upperWeekViewModels,
    required this.bottomWeekViewModels,
    required this.lessons
  });

  factory ScheduleDataSource.empty() {
    return ScheduleDataSource(
      upperWeekViewModels: [],
      bottomWeekViewModels: [],
      lessons: []
    );
  }
}
