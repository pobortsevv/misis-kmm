import 'package:flutter/material.dart';
import 'package:misis/mvvm/observer.dart';
import 'package:misis/mvvm/viewmodel.dart';

abstract class IdentifiableModel {
  int get id;
  String get name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}

enum ListLoadingState {
  isLoading,
  dataLoaded,
  loadingError
}

abstract class ListViewModel<Model extends IdentifiableModel> extends EventViewModel {
  String get title;
  String? get loadingDisclaimer;

  void loadData();
  void onTap(int id, BuildContext context);
  void searchListener(String text);
}

class LoadingEvent extends ViewEvent {
  bool isLoading;

  LoadingEvent({required this.isLoading}) : super("LoadingEvent");
}

class ListDataLoadedEvent<Model extends IdentifiableModel> extends ViewEvent {
  final List<Model> data;

  ListDataLoadedEvent({required this.data}) : super("ListDataLoadedEvent");
}

class LoadingErrorEvent extends ViewEvent {
  String error;

  LoadingErrorEvent({required this.error}) : super("LoadingErrorEvent");
}

class SearchEvent<Model extends IdentifiableModel> extends ViewEvent {
  final List<Model> foundData;

  SearchEvent({required this.foundData}) : super("SearchEvent");
}