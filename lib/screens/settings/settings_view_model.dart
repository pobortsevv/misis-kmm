import 'package:misis/mvvm/viewmodel.dart';
import 'package:misis/profile_manager/profile_manager.dart';
import 'package:misis/screens/settings/events/events.dart';

class SettingsViewModel extends EventViewModel {
  final ProfileManager _profileManager;

  SettingsViewModel({
    required ProfileManager profileManager
  }) : _profileManager = profileManager;

  void loadProfile() {
    notify(LoadingEvent());

    _profileManager.getProfile().then((value) {
      notify(DataLoadedEvent(profile: value));
    }).catchError((onError) {
      notify(LoadingErrorEvent(error: onError.toString()));
    });
  }
}