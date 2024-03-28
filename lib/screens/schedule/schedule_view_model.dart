import 'package:misis/models/domain/schedule.dart';
import 'package:misis/mvvm/viewmodel.dart';
import 'package:misis/provider/provider.dart';
import 'package:misis/screens/schedule/events/events.dart';

final class ScheduleViewModel extends EventViewModel {
  final AppProvider _provider;
  late final Schedule _schedule;

  ScheduleViewModel({required AppProvider provider}) : _provider = provider;
  
  void loadData() {
    notify(LoadingEvent());
    _provider.fetchGroupSchedule(6887, "2024-03-18", "2024-03-23")
      .then((value) {
        _schedule = value;
        notify(DataLoadedEvent(data: value));
      }).catchError((onError) {
        notify(LoadingErrorEvent(error: onError));
      });
  }
}