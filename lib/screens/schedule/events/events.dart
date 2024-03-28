import 'package:misis/models/domain/schedule.dart';
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
  final Schedule data;

  DataLoadedEvent({required this.data}) : super("DataLoadedEvent");
}

class LoadingErrorEvent extends ViewEvent {
  String error;

  LoadingErrorEvent({required this.error}) : super("LoadingErrorEvent");
}