import 'package:flutter/cupertino.dart'; // По хорошему, viewModel файлы ничего не должны знать о Flutter
import 'package:go_router/go_router.dart';
import 'package:misis/models/domain/filial.dart';
import 'package:misis/provider/provider.dart';
import 'package:misis/screens/login/list_screen/view_models/list_view_model.dart';

final class FilialsViewModel extends ListViewModel<Filial> {
  @override
  final String title = 'Выберите филиал';
  late List<Filial> _allFilials;

  final AppProvider _provider;

  FilialsViewModel({required AppProvider provider}) : _provider = provider;

  @override
  void loadData() {
    notify(LoadingEvent(isLoading: true));
    _provider.fetchFilials().then((value) {
      _allFilials = value;
      notify(ListDataLoadedEvent(data: value));
    }).catchError((onError) {
      notify(LoadingErrorEvent(error: onError.toString()));
    });
  }

  @override
  void onTap(int id, BuildContext context) {
    final filials = _allFilials;
    final selectedFilial = filials.firstWhere((element) => element.id == id);

    context.pushNamed(FilialsRoute.status.name, extra: selectedFilial);
  }

  @override
  void searchListener(String text) {
    final foundFilials = _allFilials.where((item) => item.name.toLowerCase().contains(text.toLowerCase())).toList();
    notify(SearchEvent(foundData: foundFilials));
  }
}

enum FilialsRoute { status }
