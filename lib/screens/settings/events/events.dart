import 'package:misis/models/domain/filial.dart';
import 'package:misis/models/domain/profile.dart';
import 'package:misis/models/domain/user.dart';
import 'package:misis/mvvm/observer.dart';

enum LoadingState {
  isLoading,
  dataLoaded,
  loadingError
}

class LoadingEvent extends ViewEvent {
  LoadingEvent() : super("LoadingEvent");
}

class DataLoadedEvent extends ViewEvent {
  final SettingsDataSource dataSource;

  DataLoadedEvent({required this.dataSource}) : super("DataLoadedEvent");
}

class LoadingErrorEvent extends ViewEvent {
  String error;

  LoadingErrorEvent({required this.error}) : super("LoadingErrorEvent");
}

class SettingsDataSource {
  final String profileName;
  final String profileStatus;
  final String filialName;

  SettingsDataSource({required Profile profile}) 
    : profileName = profile.user.value.name,
    profileStatus = _makeProfileStatus(profile.user.status),
    filialName = _makeFilialName(profile.filial);

  SettingsDataSource._({
    required this.profileName,
    required this.profileStatus,
    required this.filialName
  });

  static String _makeProfileStatus(Status status) {
    return switch (status) {
      Status.student => "Студент",
      Status.teacher => "Преподаватель"
    };
  }

  static String _makeFilialName(Filial filial) {
    final city = filial.city;

    return city != null ? "${filial.name}, $city" : filial.name;
  }

  factory SettingsDataSource.empty() {
    return SettingsDataSource._(profileName: "", profileStatus: "", filialName: "");
  }
}
