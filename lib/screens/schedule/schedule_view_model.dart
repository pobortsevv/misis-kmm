import 'package:misis/models/domain/profile.dart';
import 'package:misis/models/domain/schedule.dart';
import 'package:misis/models/domain/user.dart';
import 'package:misis/mvvm/viewmodel.dart';
import 'package:misis/profile_manager/profile_manager.dart';
import 'package:misis/provider/provider.dart';
import 'package:misis/screens/schedule/events/events.dart';
import 'package:misis/screens/schedule/widgets/day_widget.dart';
import 'package:misis/tools/date_time_extension.dart';

final class ScheduleViewModel extends EventViewModel {
  // Private properties

  final AppProvider _provider;
  final ProfileManager _profileManager;
  late final Profile _profile;
  late final Schedule _schedule;
  late ScheduleDataSource _dataSource;

  String? _currentWeekType;

  // Public propetries

  String get currentWeekType => _currentWeekType ?? "";

  ScheduleViewModel({
    required AppProvider provider,
    required ProfileManager profileManager
  }) : _provider = provider, _profileManager = profileManager;

  void loadData() {
    notify(LoadingEvent());

    _getProfile().then((value) {
      _profile = value;
      _loadData(value);
    }).catchError((onError) {
        notify(LoadingErrorEvent(error: onError)); // TODO: Сделать обработку UB
    });
  }

  void _updateCurrentWeekType(bool isCurrentWeekEven) {
    _currentWeekType = isCurrentWeekEven ? "Ceйчас верхняя неделя" : "Сейчас нижняя неделя";
  }
}

extension DataLoadableExtension on ScheduleViewModel {
  void _loadData(Profile profile) {
    _loadSchedule(profile).then((value) {
        _schedule = value;
        _dataSource = _makeDataSource(value);
        notify(DataLoadedEvent(dataSource: _dataSource));
      }).catchError((onError) {
        notify(LoadingErrorEvent(error: onError));
      });
  }

  Future<List<Day>> _loadWeek(int id, Status status, DateTime week) async {
    return _provider.fetchWeekSchedule(id, status, week);
  }

  Future<Schedule> _loadSchedule(Profile profile) async {
    final now = DateTime.now();
    final currentWeekNumber = now.weekNumber;

    final isEven = currentWeekNumber.isEven;

    final weeks = _getWeeks(now, isEven);
    final id = profile.user.value.id;
    final status = profile.user.status;

    final results = await Future.wait([
      _loadWeek(id, status, weeks.$1),
      _loadWeek(id, status, weeks.$2)
    ]);
    // TODO: Сделать проверку на ошибку

    _updateCurrentWeekType(isEven);

    return Schedule(upperWeek: results[0], bottomWeek: results[1]);
  }

  Future<Profile> _getProfile() async {
    final profile = await _profileManager.getProfile();

    return profile ?? (throw Exception('Failed to get Profile'));
  }
}

extension HelperExtension on ScheduleViewModel {
  (DateTime upperWeek, DateTime bottomWeek) _getWeeks(DateTime now, bool isCurrentWeekEven) {
    final DateTime upperWeek;
    final DateTime bottomWeek;

    if (isCurrentWeekEven) {
      upperWeek = now;
      bottomWeek = now.nextWeek;
    }  else {
      upperWeek = now.previousWeek;
      bottomWeek = now;
    }

    return (upperWeek, bottomWeek);
  }

  // TODO: Сделать методы обработки нажатия на день
  // TODO: Сделать метод преобразования Schedule в DataSource

  // List<DayWidgetViewModel> _makeDayWidgetViewModels(List<Day> days) {

  // }

  ScheduleDataSource _makeDataSource(Schedule schedule) {
    final upperWeekViewModels = schedule.upperWeek.map((day) {
      return DayWidgetViewModel(
        shortName: day.shortName,
        isToday: day.isToday,
        isSelected: day.isToday,
        onTap: () => _onUpperWeekDayTap(day)
      );
    }).toList();

    final bottomWeekViewModels = schedule.bottomWeek.map((day) {
      return DayWidgetViewModel(
        shortName: day.shortName,
        isToday: day.isToday,
        isSelected: day.isToday,
        onTap: () => _onBottomWeekDayTap(day)
      );
    }).toList();

    final twoWeeksDays = schedule.upperWeek + schedule.bottomWeek;
    final today = twoWeeksDays.firstWhere((element) => element.isToday);
    final todayLessons = today.lessons;

    return ScheduleDataSource(
      upperWeekViewModels: upperWeekViewModels,
      bottomWeekViewModels: bottomWeekViewModels,
      lessons: todayLessons
    );
  }
}

extension EventsTriggersExtension on ScheduleViewModel {
  void _onUpperWeekDayTap(Day day) {
    var upperWeek = _dataSource.upperWeekViewModels;
    var bottomWeek = _dataSource.bottomWeekViewModels;

    upperWeek = upperWeek.map((day) => day.copy(isSelected: false)).toList();
    bottomWeek = bottomWeek.map((day) => day.copy(isSelected: false)).toList();

    final foundDayShortName = day.shortName;
    final index = upperWeek.indexWhere((element) => element.shortName == foundDayShortName);
    upperWeek[index] = upperWeek[index].copy(isSelected: true);

    final newDataSource = ScheduleDataSource(
      upperWeekViewModels: upperWeek,
      bottomWeekViewModels: bottomWeek, 
      lessons: day.lessons
    );

    _updateDataSource(newDataSource);
  }
  
  void _onBottomWeekDayTap(Day day) {
    var upperWeek = _dataSource.upperWeekViewModels;
    var bottomWeek = _dataSource.bottomWeekViewModels;

    upperWeek = upperWeek.map((day) => day.copy(isSelected: false)).toList();
    bottomWeek = bottomWeek.map((day) => day.copy(isSelected: false)).toList();

    final foundDayShortName = day.shortName;
    final index = bottomWeek.indexWhere((element) => element.shortName == foundDayShortName);
    bottomWeek[index] = bottomWeek[index].copy(isSelected: true);

    final newDataSource = ScheduleDataSource(
      upperWeekViewModels: upperWeek,
      bottomWeekViewModels: bottomWeek, 
      lessons: day.lessons
    );

    _updateDataSource(newDataSource);
  }

  void _updateDataSource(ScheduleDataSource dataSource) {
    _dataSource = dataSource;
    notify(DataSourceUpdatingEvent(dataSource: dataSource));
  }
}