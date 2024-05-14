import 'package:misis/models/domain/profile.dart';
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
  final Profile? profile;

  DataLoadedEvent({required this.profile}) : super("DataLoadedEvent");
}

class LoadingErrorEvent extends ViewEvent {
  String error;

  LoadingErrorEvent({required this.error}) : super("LoadingErrorEvent");
}
