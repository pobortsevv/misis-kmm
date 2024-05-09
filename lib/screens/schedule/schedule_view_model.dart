import 'package:misis/models/domain/profile.dart';
import 'package:misis/models/domain/schedule.dart';
import 'package:misis/models/domain/user.dart';
import 'package:misis/mvvm/viewmodel.dart';
import 'package:misis/profile_manager/profile_manager.dart';
import 'package:misis/provider/provider.dart';
import 'package:misis/screens/schedule/events/events.dart';
import 'package:misis/tools/date_time_extension.dart';

final class ScheduleViewModel extends EventViewModel {
  // Private properties

  final AppProvider _provider;
  final ProfileManager _profileManager;
  late final Profile _profile;
  late final Schedule _schedule;
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

  void _loadData(Profile profile) {
    _loadSchedule(profile).then((value) {
        _schedule = value;
        notify(DataLoadedEvent(data: value));
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

  void _updateCurrentWeekType(bool isCurrentWeekEven) {
    _currentWeekType = isCurrentWeekEven ? "Ceйчас верхняя неделя" : "Сейчас нижняя неделя";
  }
}